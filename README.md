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
  
    - From here you can run it using tmux in a separate container. You can use the following commands after setting up a tmux window:
  
  `sudo python3 python-rest/API/server.py`

    - Updating to most recent branch and running:

  `cd python-rest`
  
  `git pull https://github.com/hugheylab/co-occurence_statistics`
  
  `cd`
  
  `sudo python3 python-rest/API/server.py`

- Once the app is running, you can connect via going to the public IP address of the EC2 instance and adding "/<endpoint>" to your desired endpoint. The current IP address in use is http://18.220.193.105

- Basic Authorization is enabled on this endpoint. If using curl or manually constructing the http request, you simply need to add a header with the value 'Authorization: Basic \<base64encode\>' where \<base64encode\> is 'username:password' (with your username and password instead of those words) encoded in base64. Alternatively, if you are using httr to construct the request, you can modify the following code to do basic authorization:

`GET(
"http://httpbin.org/basic-auth/user/passwd",
authenticate("user", "passwd")
)`


## Endpoints

`/general_exposure`

- This endpoint queries against the "general_exposure" table.
- A simple query against this endpoint will return the first 50 results in JSON representation.
- Accepted Parameters:
  - limit
    - This is the max amount of records you want to be returned by the query.
    - The default is no limit
    - Example
      
      - `.../general_exposure?limit=20`
      - This returns a list limited to 20 records instead of the default of no limit.
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
      
`/phenotype_specific_exposures`

- This endpoint queries against the "phenotype_specific_exposures" table.
- A simple query against this endpoint will return the first 50 results in JSON representation.
- Accepted Parameters:
  - limit
    - This is the max amount of records you want to be returned by the query.
    - The default is no limit
    - Example
      
      - `.../phenotype_specific_exposures?limit=20`
      - This returns a list limited to 20 records instead of the default of 50.
  - phecodeIds
    - This is a comma separated list of phecodes you wish to filter the list to return.
    - Example
      
      - `.../phenotype_specific_exposures?phecodeIds=12345,54321,67890`
      - This returns a list with all records where phecode is equal to 12345, 54321, or 67890.
  - ingredientIds
    - This is a comma separated list of ingredient Ids you wish to filter the list to return.
    - Example
      
      - `.../phenotype_specific_exposures?ingredientIds=12345,54321,67890`
      - This returns a list with all records where ingredient_id is equal to 12345, 54321, or 67890.
  - phecodeName
    - This is used as a case-insensitive search against the phecode_name column
    - Example
    
        - `.../phenotype_specific_exposures?phecodeName=pro`
        - This returns a list with all records where phecode_name contains the string "pro" ignoring case sensitivity.
  - ingredientName
    - This is used as a case-insensitive search against the ingredient_name column
    - Example
    
        - `.../phenotype_specific_exposures?ingredientName=ace`
        - This returns a list with all records where ingredient_name contains the string "ace" ignoring case sensitivity.

*Note: All parameters that filter the list returned do so by combining them with AND statements. For example, if you query the phenotype_specific_exposures endpoint and specify both phecodeIds and ingredientIds, it will return a filtered list where both criteria are met.
