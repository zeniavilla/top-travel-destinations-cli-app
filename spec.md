# Specifications for the CLI Assessment

Specs:

- [x] Have a CLI for interfacing with the application - The CLI class allows a user to interface with the application in the form of a menu. The user can choose to list destinations, display by continent, learn more about a particular destination, and finally, exit the program.
- [x] Pull data from an external source - I created a Scraper class that parses information from Tripadvisor's 25 Best Destinations page and each destination page. That data was ultimately set as the properties of destination objects.
- [x] Implement both list and detail views - The initial output of the app is the list view (Top 25 destinations). There is a second list option that is by continent. When the user chooses a number to learn more about a destination, the detail view is outputted. 