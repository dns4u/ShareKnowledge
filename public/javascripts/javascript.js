function onlyAlphabets(e, t) {
  try
    {
      if (window.event) 
        {
          var charCode = window.event.keyCode;
        }
      else if (e)
        {
          var charCode = e.which;
        }
      else { return true; }
        if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123)||charCode <31)
          return true;
        else
          alert("Please, enter alphabets only");
        return false;
    }
  catch (err) 
    {
      alert(err.Description);
    }
  }

function onlyNumber(e, t) {
  try
    {
      if (window.event) 
        {
          var charCode = window.event.keyCode;
        }
      else if (e)
        {
          var charCode = e.which;
        }
      else { return true; }
        if ((charCode > 47 && charCode < 58)||charCode <31)
          return true;
        else
          alert("Please, enter number only");
        return false;
    }
  catch (err) 
    {
      alert(err.Description);
    }
  }

function required()  
  {  
    var firstname=document.getElementById("firstname").value;
    var lastname=document.getElementById("lastname").value;
    var gender=document.getElementById("gender").value;
    var mobilenumber=document.getElementById("mobilenumber").value;
    var email=document.getElementById("email").value;
    var password=document.getElementById("password").value;
    var confirmpassword=document.getElementById("confirmpassword").value;
    var position=document.getElementById("position").value;
    if (firstname == "" || lastname == "" || gender == "Select Gender" || address == "" || mobilenumber == "" || email == "" || password == "" || confirmpassword == "" || position == "" )  
      {  
        alert("Please, fill all fields.");  
        return false;  
      }
    if (password == confirmpassword)
    {
      return true;
    } 
    else
      alert("Password doesn't match");
    return false;
    }  
function require()  
  {  
    var search=document.getElementById("file_search").value;
    if(search == "")
    {
      return false;
    }
    else
      return true;
  }