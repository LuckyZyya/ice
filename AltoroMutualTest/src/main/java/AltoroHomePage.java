import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

public class AltoroHomePage {
    WebDriver driver;
    @FindBy(xpath="//*[@id=\"_ctl0__ctl0_Content_Main_promo\"]/table/tbody/tr[1]/td/h2")
    WebElement homePageUserName;

    public AltoroHomePage(WebDriver driver){
        this.driver = driver;
        //This initElements method will create  all WebElements
        PageFactory.initElements(driver, this);
    }

    //Get the User name from Home Page
    public String getHomePageUserName(){
        return	homePageUserName.getText();
    }
}
