package websocket

type ConcurrentMap struct {
	data       map[string]interface{}
	sender     chan KeyValue
	getter     chan string
	receiver   chan interface{}
	subscriber chan interface{}
}

// NewConcurrentMap create a new instance of a concurrent hashmap and run it
func NewConcurrentMap() *ConcurrentMap {
	c := &ConcurrentMap{
		data:       make(map[string]interface{}),
		sender:     make(chan KeyValue),
		getter:     make(chan string),
		subscriber: make(chan interface{}),
	}
	go c.run()
	return c
}

// Set a value to the hashmap
func (c *ConcurrentMap) Set(key string, value interface{}) {
	c.sender <- KeyValue{key, value}
}

// Get a value from the hashmap
func (c *ConcurrentMap) Get(key string) interface{} {
	c.getter <- key
	return <-c.receiver
}

// Subscribe Add a subscriber to check for value added
func (c *ConcurrentMap) Subscribe(handler func(interface{})) {
	go func() {
		for {
			select {
			case item := <-c.subscriber:
				handler(item)
			}
		}
	}()
}

// GetAll Get all result
func (c *ConcurrentMap) GetAll() map[string]interface{} {
	return c.data
}

func (c *ConcurrentMap) run() {
	for {
		select {
		case item := <-c.sender:
			c.data[item.Key] = item.Value
			c.subscriber <- item.Value
		case key := <-c.getter:
			c.receiver <- c.data[key]
		}
	}
}

type KeyValue struct {
	Key   string
	Value interface{}
}
