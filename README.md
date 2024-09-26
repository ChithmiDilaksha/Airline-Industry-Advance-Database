# Flight Management System
This project sets up a flight management system with multiple tables to store and manage information about flights, maintenance, employees, passengers, and tickets. The system is designed to model real-world entities and their relationships within a flight management context.

## Database Structure
### Tables Overview:
1. Flight:

   Stores flight information such as flight code, flight type, departure and arrival locations, and dates.Flight codes are validated to start with 'FL' using a CHECK constraint.

3. Maintenance:

      Tracks maintenance activities for flights with fields like maintenance ID, date, and cost.
   
      Linked to the flight table through the FCode field as a foreign key.

3. Airport:

      Contains airport details, including airport code, name, and city.

4. Travels:

      Links flights to airports. Each entry maps a flight to a specific airport using foreign keys from both the flight and airport tables.

5. Employee:

      Holds basic employee details such as employee ID and name, and associates employees with specific flights.

6. Employee Crew and Employee Admin:

      These tables store additional details about crew members and administrative staff, referencing the employee table.

7. Passenger:

      Contains passenger information, such as ID, passport number, name, gender, and the flight they are booked on.
8. Ticket:

     Stores ticket information, including ticket ID, price, seat number, meal plan, and date of validation. Each ticket is linked to a passenger using the passenger’s ID and passport number.
