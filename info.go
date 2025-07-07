package main

import "os"

type AppInfo struct {
	Name        string `json:"name"`
	Version     string `json:"version"`
	Environment string `json:"environment"`
}

func GetAppInfo() AppInfo {

	return AppInfo{
		Name:        GetAppAttributeValue("APP_NAME"),
		Version:     GetAppAttributeValue("VERSION"),     // Reemplaza con la versión real
		Environment: GetAppAttributeValue("ENVIRONMENT"), // Cambia según el entorno (dev, prod, etc.)
	}
}

func GetAppAttributeValue(envVarName string) string {
	value, ok := os.LookupEnv(envVarName)
	if ok {
		return value
	}
	return "UNKNOWN"
}
