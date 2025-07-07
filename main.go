package main

import (
	"encoding/json"
	"net/http"
)

func main() {
	appInfo := GetAppInfo()

	http.HandleFunc("/api/v1/healtz", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "text/plain")
		w.WriteHeader(http.StatusOK)
		if err := json.NewEncoder(w).Encode(appInfo); err != nil {
			http.Error(w, "Error encoding JSON", http.StatusInternalServerError)
			return
		}
	})

	http.ListenAndServe(":8080", nil)
}
