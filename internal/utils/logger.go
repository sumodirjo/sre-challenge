package utils

import (
	"log"
	"os"
)

func InitLogger(level string) {
	switch level {
	case "debug":
		log.SetFlags(log.Ldate | log.Ltime | log.Lshortfile)
	case "info":
		log.SetFlags(log.Ldate | log.Ltime)
	case "error":
		log.SetFlags(log.Ldate | log.Ltime | log.Lshortfile)
	default:
		log.SetFlags(log.Ldate | log.Ltime)
	}

	log.SetOutput(os.Stdout)
	log.Println("Logger initialized with level:", level)
}
