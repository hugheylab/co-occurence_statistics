# Co-Occurrence Statistics API
## Installation/Current Use
This is an API to query against co-occurrence statistics for drug monitor data. This is set up by creating a Postgres database on an Amazon RDS server and hosting/running code on an Amazon EC2 instance in python.

- To get latest version/run the app, I used the following commands on our EC2 instance:
    - Ensure Pip is installed and the python packages are installed as well (this assumes you have the requirements.txt file from the repository with all python package dependencies):

  `sudo apt update`
  
  `sudo apt install python3-pip`
  
  `pip3 install -r requirements.txt`

    - Initial setup including the clone from github:

  `git clone https://github.com/hugheylab/co-occurence_statistics python-rest`
  
  `cd python-rest`
  
  `git pull https://github.com/hugheylab/co-occurence_statistics`
  
  `cd`
  
  `sudo python3 python-rest/API/server.py`

    - Updating to most recent branch and running:

  `cd python-rest`
  
  `git pull https://github.com/hugheylab/co-occurence_statistics`
  
  `cd`
  
  `sudo python3 python-rest/API/server.py`

- Once the app is running, you can connect via going to the public IP address of the EC2 instance and adding "/<endpoint>" to your desired endpoint. The current IP address in use is http://18.220.193.105

## Endpoints

`/general_exposure`

- This endpoint queries against the "general_exposure" table.
- A simple query against this endpoint will return the first 50 results in JSON representation.
- Accepted Parameters:
  - limit
    - This is the max amount of records you want to be returned by the query.
    - The default is limit=50
    - Example
      
      - `.../general_exposure?limit=20`
      - This returns a list limited to 20 records instead of the default of 50.
  - ids
    - This is a comma separated list of ingredient Ids you wish to return back.
    - Example
      
      - `.../general_exposure?ids=12345,54321,67890`
      - This returns a list with the 3 records where ingredient_id is equal to 12345, 54321, or 67890.
  - name
    - This is a string that executes a case-insensitive contains query on the ingredient_name field.
    - Example
      
      - `.../general_exposure?name=protein&limit=5`
      - This returns a list of the first 5 records where ingredient_name contains the string "protein" ignoring case.
