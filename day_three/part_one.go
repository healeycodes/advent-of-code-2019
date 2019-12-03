package main

import (
	"fmt"
	"io/ioutil"
	"math"
	"os"
	"strconv"
	"strings"
)

func getPoints(wirePath []string) map[string][]int {
	dir := 0
	travel := 0
	pos := []int{0, 0}
	points := make(map[string][]int)
	for _, instruction := range wirePath {
		distance, _ := strconv.Atoi(instruction[1:])
		switch instruction[0:1] {
		case "U":
			dir = 1
			travel = 1
		case "R":
			dir = 0
			travel = 1
		case "D":
			dir = 1
			travel = -1
		case "L":
			dir = 0
			travel = -1
		}
		for i := 0; i < distance; i++ {
			pos[dir] += travel

			// Store all visited points, we'll check the maps against each other later
			points[strconv.Itoa(pos[0])+","+strconv.Itoa(pos[1])] = []int{pos[0], pos[1]}
		}
	}
	return points
}

func main() {
	filename := os.Args[1]
	input, err := ioutil.ReadFile(filename)
	if err != nil {
		panic("Problem reading file :(")
	}
	paths := strings.Split(string(input), "\n")
	firstPath := getPoints(strings.Split(paths[0], ","))
	secondPath := getPoints(strings.Split(paths[1], ","))

	manhattenDistances := []int{}
	for point, coords := range firstPath {
		if _, ok := secondPath[point]; ok {
			man := math.Abs(float64(coords[0])-0) + math.Abs(0-float64(coords[1]))
			manhattenDistances = append(manhattenDistances, int(man))
		}
	}

	// Find minimum
	m := 0
	for i, e := range manhattenDistances {
		if i == 0 || e < m {
			m = e
		}
	}
	fmt.Println(m)
}
