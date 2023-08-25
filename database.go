package main

import (
	"errors"
	"fmt"

	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

type AppUser struct {
	gorm.Model
	ID      string `gorm:"column:id;primaryKey"`
	Balance int32  `gorm:"column:balance"`
	Name    string `gorm:"column:name"`
}

type UserPayment struct {
	gorm.Model
	ID      string `gorm:"column:id;primaryKey"`
	UserId  string `gorm:"column:userId"`
	Amount  int32  `gorm:"column:amount"`
	IsPayed bool   `gorm:"column:isPayed"`
}

type DBConnection struct {
	host     string
	user     string
	pass     string
	dbName   string
	port     string
	sslmode  bool
	timeZone string
}

type SavePaymentParams struct {
	ID     string
	Amount int32
	UserID string
}

func (AppUser) TableName() string {
	return "users"
}

func ConnectDB(connection DBConnection) (*gorm.DB, error) {
	dsn := fmt.Sprintf("host=%s user=%s password=%s dbname=%s port=%s sslmode=%s TimeZone=%s", connection.host, connection.user, connection.pass, connection.dbName, connection.port, boolToStr(connection.sslmode), connection.timeZone)
	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		return nil, fmt.Errorf("failed to connect to the database: %w", err)
	}

	return db, nil
}

func boolToStr(b bool) string {
	if b {
		return "enable"
	}
	return "disable"
}

func ReduceBalance(userId string, reduceAmount int32, db *gorm.DB) error {
	var user AppUser

	result := db.First(&user, "id = ?", userId)
	if result.Error != nil {
		if errors.Is(result.Error, gorm.ErrRecordNotFound) {
			return errors.New("user not found")
		}
		return fmt.Errorf("failed to retrieve user: %w", result.Error)
	}

	user.Balance -= reduceAmount

	result = db.Save(&user)
	if result.Error != nil {
		return fmt.Errorf("failed to update user balance: %w", result.Error)
	}

	return nil

}

func GetUser(userId string, db *gorm.DB) (*AppUser, error) {

	var user AppUser

	result := db.First(&user, "id = ?", userId)

	if result.Error != nil {
		if errors.Is(result.Error, gorm.ErrRecordNotFound) {
			return nil, errors.New("user not found")
		}
		return nil, fmt.Errorf("failed to retrieve user: %w", result.Error)
	}

	return &user, nil
}

func AddUser(userId string, name string, db *gorm.DB) (*AppUser, error) {
	fmt.Print("Going to create" + userId)

	user := AppUser{
		ID:      userId,
		Name:    name,
		Balance: 10,
	}

	result := db.Create(&user)
	if result.Error != nil {
		return nil, fmt.Errorf("failed to add user: %w", result.Error)
	}

	return &user, nil
}

func SavePayment(params SavePaymentParams, db *gorm.DB) error {

	var payment UserPayment

	result := db.First(&payment, "id = ?", params.ID)
	if result.Error == nil {
		return fmt.Errorf("payment already exist %w", result.Error)
	}

	payment = UserPayment{
		ID:      params.ID,
		UserId:  params.UserID,
		Amount:  params.Amount,
		IsPayed: false,
	}

	result = db.Create(&payment)
	if result.Error != nil {
		return fmt.Errorf("failed to add payment: %w", result.Error)
	}

	return nil
}

func CheckPayment(paymentId string, db *gorm.DB) error {
	var payment UserPayment

	result := db.First(&payment, "id = ?", paymentId)
	if result.Error != nil {
		if errors.Is(result.Error, gorm.ErrRecordNotFound) {
			return errors.New("payment not found")
		}
		return fmt.Errorf("failed to retrieve payment: %w", result.Error)
	}

	if payment.IsPayed {
		return errors.New("payment already received")
	}

	payment.IsPayed = true
	result = db.Save(&payment)
	if result.Error != nil {
		return fmt.Errorf("failed to update payment status: %w", result.Error)
	}

	return AddBalance(payment.UserId, payment.Amount, db)

}
func AddBalance(userId string, toAddBalance int32, db *gorm.DB) error {
	var user AppUser

	result := db.First(&user, "id = ?", userId)
	if result.Error != nil {
		if errors.Is(result.Error, gorm.ErrRecordNotFound) {
			return errors.New("user not found")
		}
		return fmt.Errorf("failed to retrieve user: %w", result.Error)
	}

	user.Balance += toAddBalance

	result = db.Save(&user)
	if result.Error != nil {
		return fmt.Errorf("failed to update user balance: %w", result.Error)
	}

	return nil
}

func UserExists(userId string, db *gorm.DB) (*AppUser, error) {
	var user AppUser
	result := db.First(&user, "id = ?", userId)
	if result.Error != nil {
		if errors.Is(result.Error, gorm.ErrRecordNotFound) {
			return nil, nil
		}
		return nil, fmt.Errorf("failed to check user existence: %w", result.Error)
	}
	return &user, nil
}
