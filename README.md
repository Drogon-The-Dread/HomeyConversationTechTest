# Project Setup and Usage Guide

## Local Environment Setup

### Prerequisites
Ensure you have the following installed:
- **Ruby 3.2** 
- **PostgreSQL** (configured to allow local connections without a password)

### Installation Steps
1. Install necessary gems:
   ```bash
   bundle install
   ```
2. Prepare the database:
   ```bash
   rails db:prepare
   ```
3. Seed the database:
   ```bash
   rails db:seed
   ```

### Running the Web Server
Start the Rails server:
```bash
rails s
```

### Manual Testing
To test the application manually:
1. Open your browser and navigate to: [http://localhost:3000](http://localhost:3000)
   
2. Use the following credentials to log in:
     *Email*: `user0@test.com` OR `user1@test.com`
     *Password*: `password`

3. Interact with the app:
   - Select any project and add comments as needed.
   - As the project owner, you can also modify the project status:
     - **Note**: If you mark the project as "cancelled" or "completed", it **cannot** be reverted.

4. To observe real-time updates:
   - Open two separate browsers or use an incognito window to log in as both users simultaneously.

### Running Automated Tests
The tests are built using RSpec. Run them with:
```bash
rspec
```

---

## Docker Environment Setup

### Building and Running the Application

1. Build & run the Docker containers:
   ```bash
   docker compose up
   ```

2. Setup the database:
   ```bash
   docker compose exec web rails db:prepare db:seed
   ```

3. Start the application:
   ```bash
   docker compose up
   ```

The application will be accessible at: [http://localhost:3000](http://localhost:3000)