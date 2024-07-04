package com.example;

class Counter implements AutoCloseable {
    private int count;
    private boolean closed;

    public Counter() {
        this.count = 0;
        this.closed = false;
    }

    public void add() {
        if (closed) {
            throw new IllegalStateException("Counter is closed");
        }
        count++;
    }

    public int getCount() {
        return count;
    }

    @Override
    public void close() {
        closed = true;
    }

    public static void validateResourceUsage(Counter counter) throws Exception {
        if (counter == null || counter.closed) {
            throw new Exception("Resource was not properly used or left open");
        }
    }
}
