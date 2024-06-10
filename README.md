# Chat System

This project is a chat system built with Ruby on Rails, using Sidekiq for background job processing and Redis for job queuing. The system is containerized using Docker and Docker Compose.

## Getting Started

### Prerequisites

Ensure you have the following installed on your local machine:
- Docker
- Docker Compose

### Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/3omarbadr/chat-system.git
    cd chat-system
    ```

2. Build and start the containers:

    ```bash
    docker compose up
    ```

3. Set up the database:

   Once the database service is up and running, run the migrations:

    ```bash
    docker exec web rake db:migrate
    ```

### Running Tests

To run the test suite, use the following command:

```bash
docker exec web rspec
````

### API Endpoints

You can find the API documentation and endpoints here:
```bash
https://documenter.getpostman.com/view/16204995/2sA3XLG4xE#6bdde03b-a4dc-4677-939f-486720a65d06
```

### Notes
```bash
- Ensure that you have Docker and Docker Compose installed and running on your machine.
- The system uses Elasticsearch for searching messages within a chat.
- High concurrency is handled using Sidekiq and Redis.
```
