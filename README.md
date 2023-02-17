# Description
This image is designed to be used to execute HDC backups for clinic's running OpenOSP's distribution of Oscar EMR.

# Dependencies
Two environment variables: 
- **MYSQL_ROOT_PASSWORD**
- **CLINIC_SLUG**
  
The following files:
- A GPG key
- AWS CLI credentials
- AWS CLI configuration

# References
The code in here was adapted from OpenOSP's HDC backup code in their repository. 