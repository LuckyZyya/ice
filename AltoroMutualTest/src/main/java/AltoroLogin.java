import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

public class AltoroLogin {
    WebDriver driver;
    @FindBy(xpath="//*[@id=\"uid\"]")
    WebElement userName;

    @FindBy(xpath="//*[@id=\"passw\"]")
    WebElement password;

    @FindBy(xpath="//*[@id=\"login\"]/table/tbody/tr[3]/td[2]/input")
    WebElement login;

    public AltoroLogin(WebDriver driver){
        this.driver = driver;
        PageFactory.initElements(driver, this);
    }
    public void setUserName(String strUserName){
        userName.sendKeys(strUserName);

    }
    public void setPassword(String strPassword){
        password.sendKeys(strPassword);
    }

    public void clickLogin(){
        login.click();
    }


    public void loginToAltoro(String strUserName,String strPassword){
        //Fill user name
        this.setUserName(strUserName);
        //Fill password
        this.setPassword(strPassword);
        //Click Login button
        this.clickLogin();

    }
}
