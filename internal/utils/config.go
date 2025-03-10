package utils

import (
	"log"
	"os"

	"gopkg.in/yaml.v2"
)

type Config struct {
	Server struct {
		Port string `yaml:"port"`
	} `yaml:"server"`
	Logging struct {
		Level string `yaml:"level"`
	} `yaml:"logging"`
	Database struct {
		URI  string `yaml:"uri"`
		Name string `yaml:"name"`
	} `yaml:"database"`
	Observability struct {
		OTLPEndpoint string `yaml:"otlp_endpoint"`
	} `yaml:"observability"`
}

var AppConfig Config

func LoadConfig() Config {
	file, err := os.Open("config/config.yaml")
	if err != nil {
		log.Fatalf("Failed to open config file: %v", err)
	}
	defer file.Close()

	decoder := yaml.NewDecoder(file)
	if err := decoder.Decode(&AppConfig); err != nil {
		log.Fatalf("Failed to parse config file: %v", err)
	}

	return AppConfig
}
