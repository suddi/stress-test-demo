package main

import (
	"fmt"
	"golang.org/x/crypto/bcrypt"
	"log"
	"net/http"
	"strings"
)

func computeHash(password []byte) (string) {
	hash, err := bcrypt.GenerateFromPassword(password, 10)
	if err != nil {
		panic(err)
	}
	return string(hash[:])
}

func handleRoot(w http.ResponseWriter, r *http.Request) {
	input := strings.Replace(r.URL.Path, "/", "", 1)
	hash := computeHash([]byte(input))
	response := fmt.Sprintf("{\"status\":\"OK\",\"hash\":\"%s\"}", hash)
	w.Header().Set("Cache-Control", "no-cache")
	w.Header().Set("Connection", "close")
	w.Header().Set("Content-Type", "application/json")
	w.Header().Set("Content-Length", fmt.Sprint(len(response)))
	w.WriteHeader(http.StatusOK)
	fmt.Fprint(w, response)
}

func main() {
	http.HandleFunc("/", handleRoot)
	log.Println("server is listening on 3002")
	err := http.ListenAndServe(":3002", nil)
	if err != nil {
		log.Fatal("server failed to start")
	}
}
