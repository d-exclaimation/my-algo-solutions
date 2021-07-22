//
//  main.go
//  al-go
//
//  Created by d-exclaimation on 6:32 AM.
//  Copyright © 2021 d-exclaimation. All rights reserved.
//

package main

import (
	"fmt"
	"time"

	. "github.com/d-exclaimation/al-go/websocket"
)

func main() {
	ctx := NewConcurrentMap()

	ctx.Set("one", 0)
	go setOne(time.Second*1, "one second 1", ctx)
	go setOne(time.Second*2, "two second", ctx)
	go setOne(time.Second*3, "3 second", ctx)
	go setOne(time.Second*1, "one second 2", ctx)
	go setOne(time.Second*10, "ten second", ctx)
	go setOne(time.Second*4, "four second", ctx)
	go setOne(time.Second*5, "five second", ctx)
	go setOne(time.Second*30, "last", ctx)

	ctx.Subscribe("one", func(i interface{}) {
		fmt.Printf("%v\n", i)
	})

	ctx.Subscribe("one", func(i interface{}) {
		fmt.Printf("lol: %v\n", i)
	})
	time.Sleep(time.Second * 40)
}

func setOne(delay time.Duration, val interface{}, ctx *ConcurrentMap) {
	time.Sleep(delay)
	ctx.Set("one", val)
}

const youtubevideolink = "https://www.youtube.com/watch?v=_0-_0-_0-_0"
