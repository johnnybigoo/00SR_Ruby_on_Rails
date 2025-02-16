# Fill Form App

00SR - Develop Native Application Without A Database

In this project, I developed a simulated Customer Relationship Management (CRM) web application designed specifically for a competency task that prohibits the use of a traditional database. The application allows users to complete a lead submission form, saving the input data directly into a JSON file for persistent storage. Users can then access a dedicated "Consult Leads" page to review their entries and even download the data as a CSV file. This solution demonstrates an effective approach to native application development by leveraging file-based data management, robust input validation, and dynamic data export capabilities without relying on a conventional database system.

The project uses Ruby on Rails with Tailwind for frontend.
>Ruby version: 3.1.6
>
>Rails version: 7.1.5
>
>Gems:
>
>tailwindcss-rails
>
>bootsnap
>
>importmap-rails

**Configuration**
Since there’s no database, we will create a plain Ruby model using ActiveModel and handle JSON file storage.

**How to run the test suite**
To perform the tests, clone or fork the project and run the command:

>rails test
