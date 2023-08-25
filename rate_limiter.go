package main

import (
	"context"
	"errors"
	"net"
	"sync"
	"time"

	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/peer"
	"google.golang.org/grpc/status"
)

type RateLimiter struct {
	limiters map[string]*TokenBucket
	mutex    sync.Mutex
}

func NewRateLimiter() *RateLimiter {
	return &RateLimiter{
		limiters: make(map[string]*TokenBucket),
	}
}

func (rl *RateLimiter) GetGuestUserBalance(ctx context.Context) (int32, error) {
	clientIP, err := getClientIP(ctx)
	if err != nil {
		return 0, err
	}

	limiter := rl.getLimiter(clientIP.String())
	if limiter == nil {
		return 0, status.Error(codes.PermissionDenied, "Access denied")
	}

	return limiter.tokens, nil
}

func (rl *RateLimiter) LimitRequest(ctx context.Context) error {
	clientIP, err := getClientIP(ctx)
	if err != nil {
		return err
	}

	limiter := rl.getLimiter(clientIP.String())
	if limiter == nil {
		return status.Error(codes.PermissionDenied, "Access denied")
	}

	if !limiter.Allow() {
		return status.Error(codes.ResourceExhausted, "Too many requests")
	}

	return nil
}

func (rl *RateLimiter) getLimiter(key string) *TokenBucket {
	rl.mutex.Lock()
	defer rl.mutex.Unlock()

	if limiter, ok := rl.limiters[key]; ok {
		return limiter
	}

	limiter := NewTokenBucket()
	rl.limiters[key] = limiter

	return limiter
}

type TokenBucket struct {
	capacity int32
	tokens   int32
	interval time.Duration
	lastTime time.Time
	mutex    sync.Mutex
}

func NewTokenBucket() *TokenBucket {
	return &TokenBucket{
		capacity: 5,
		tokens:   5,
		interval: time.Minute,
		lastTime: time.Now(),
	}
}

func (tb *TokenBucket) Allow() bool {
	tb.mutex.Lock()
	defer tb.mutex.Unlock()

	if tb.tokens > 0 {
		tb.tokens--
		return true
	}

	return false
}

// Function to retrieve the client's IP address from the context
func getClientIP(ctx context.Context) (net.IP, error) {
	pr, ok := peer.FromContext(ctx)
	if !ok {
		return nil, errors.New("failed to get peer from context")
	}
	addr := pr.Addr

	tcpAddr, ok := addr.(*net.TCPAddr)
	if !ok {
		return nil, errors.New("unexpected address type")
	}

	return tcpAddr.IP, nil
}
