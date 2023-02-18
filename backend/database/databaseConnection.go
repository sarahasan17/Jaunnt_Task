package database

import (
	"context"
	"fmt"

	// "log"
	// "os"
	"time"

	// "github.com/joho/godotenv"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"go.mongodb.org/mongo-driver/mongo/readpref"

	constants "jaunnt-backend/constants"
)

func DBinstance() *mongo.Client {

	/* err := godotenv.Load(".env")
	if err != nil {
		log.Fatal("error in loading env")
	}
	MongoDb := os.Getenv("MONGODB_URL") */
	var (
		client   *mongo.Client
		mongoURL = constants.MONGODBURL
	)

	client, err := mongo.NewClient(options.Client().ApplyURI(mongoURL))

	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	err = client.Connect(ctx)

	ctx, cancel = context.WithTimeout(context.Background(), 10*time.Second)
	if err = client.Ping(ctx, readpref.Primary()); err != nil {
		fmt.Println("could not ping to mongo db service: %v\n", err)
	}
	defer cancel()

	fmt.Println("connected to database:", mongoURL)
	return client
}

var Client *mongo.Client = DBinstance()

func OpenCollection(client *mongo.Client, collectionName string) *mongo.Collection {
	var collection *mongo.Collection = (*mongo.Collection)(client.Database("cluster0").Collection(collectionName))
	return collection
}
