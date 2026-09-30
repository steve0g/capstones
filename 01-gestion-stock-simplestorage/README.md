\# Gestion Stock Korbanas



A Solidity contract demonstrating core concepts from the Simple Storage section: 

struct, dynamic array, mapping, storage vs memory vs calldata, function visibility, 

and for loops — combined into a small stock management system for Korbanas.



\## Features



\- Add a laptop to stock (auto-marked as available)

\- Look up the price of a specific laptop by its position

\- Mark a laptop as sold

\- Count how many laptops are currently available

\- Track the total historical count of each model added

\- Check if a model was never stocked or is currently out of stock



\## Known limitation



`marquerLaptopVendu` and `ajouterLaptop` are currently `public` with no access 

control — anyone can call them. This will be addressed as access control 

concepts are covered later in the course.

