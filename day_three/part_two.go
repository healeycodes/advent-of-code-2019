package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"strconv"
	"strings"
)

func getPoints(wirePath []string) map[string][]int {
	dir := 0
	travel := 0
	pos := []int{0, 0, 0}
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
			pos[2]++
			point := strconv.Itoa(pos[0]) + "," + strconv.Itoa(pos[1])

			// Store wire steps for the first visit to this point
			if _, ok := points[point]; !ok {
				points[point] = []int{pos[0], pos[1], pos[2]}
			}
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

	signalDelays := []int{}
	for point, coords := range firstPath {
		if val, ok := secondPath[point]; ok {
			signalDelays = append(signalDelays, coords[2]+val[2])
		}
	}

	// Find minimum
	s := 0
	for i, e := range signalDelays {
		if i == 0 || e < s {
			s = e
		}
	}
	fmt.Println(s)
}
