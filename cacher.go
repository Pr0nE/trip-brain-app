package main

import (
	"fmt"
	"os"

	"github.com/go-redis/redis"
)

type Cacher interface {
	Get(key string) (result string, found bool)
	Save(key string, value string)
	GetArr(key string) ([]string, bool)
	SetArr(key string, values []string)
}

type RedisCacher struct {
	client *redis.Client
}

func NewCacher() (*RedisCacher, error) {
	redisClient := redis.NewClient(&redis.Options{
		Addr:     os.Getenv("REDIS_ADDRESS"),
		Password: os.Getenv("REDIS_PASS"),
		DB:       0,
	})

	_, err := redisClient.Ping().Result()
	if err != nil {
		return nil, err
	}

	return &RedisCacher{
		client: redisClient,
	}, nil
}

func (c *RedisCacher) Get(key string) (string, bool) {
	result, err := c.client.Get(key).Result()
	if err == redis.Nil {
		return "", false
	} else if err != nil {
		fmt.Println("Redis error:", err)
		return "", false
	}
	return result, true
}

func (c *RedisCacher) Save(key string, value string) {
	err := c.client.Set(key, value, 0).Err()
	if err != nil {
		fmt.Println("Redis error:", err)
	}
}

func (c *RedisCacher) GetArr(key string) ([]string, bool) {
	result, err := c.client.LRange(key, 0, -1).Result()
	fmt.Println(result)
	fmt.Println(err)

	if err == redis.Nil {
		return nil, false
	} else if err != nil {
		fmt.Println("Redis error:", err)
		return nil, false
	}
	if len(result) < 1 {
		return nil, false
	}
	return result, true
}

func (c *RedisCacher) SetArr(key string, values []string) {
	err := c.client.Del(key).Err()
	if err != nil {
		fmt.Println("Redis error:", err)
		return
	}

	if len(values) > 0 {
		err := c.client.RPush(key, values).Err()
		if err != nil {
			fmt.Println("Redis error:", err)
		}
	}
}
