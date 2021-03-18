# Quick and Nimble

**Quick**: Quick is a behavior-driven development framework for Swift and Objective-C.

**Nimble**: Quick works together with Nimble that is a assertion framework that make it easier and clearer to match the expectations on tests.



## Example:

```
import Quick
import Nimble

class RestaurantListSpecification : QuickSpec {

	....
	....
	
	override func spec() {
	
        beforeEach {
            
        }
        
        describe("the main screen of the app is loaded") {
            context("no area has been selected") {
                it("the Next button is not enabled") {
                    
                    self.prepareForSearchViewControllerTests()
                    self.searchVC!.viewDidLoad()
                    
                    expect(self.viewRestaurantButtonStub!.isEnabled).to(equal(false))
                }
            }
        }
        
        describe("the main screen of the app is loaded") {
            context("an area in London has been selected") {
                it("the Next button is enabled") {
    
                    self.prepareForSearchViewControllerTests()
                    self.searchVC!.viewDidLoad()
                    self.searchVC!.pickerView(self.locationPickerStub!, didSelectRow: 0, inComponent: 0)
                    
                    expect(self.viewRestaurantButtonStub!.isEnabled).to(equal(true))
                }
            }
        }
        
        describe("the user has selected a location") {
            context("the Next button is tapped") {
                it("a new screen appears with a list of restaurants in that location") {
                    self.prepareForSearchViewControllerTests()
                    self.searchVC!.pickerView(self.locationPickerStub!, didSelectRow: 0, inComponent: 0)
                    self.searchVC!.onViewListings(self)
                    
                    expect(self.searchVC!.displayResultsScreenCalled).to(equal(true))
                }
            }
        }
        
        describe("the list of restaurants is visible on the screen") {
            context("a restaurant’s name is displayed in that list") {
                it("the listing should be accompanied with the name of the nearest tube station") {
                    
                    self.prepareForRestaurantTableViewCellTests()
                    self.restaurantTableViewCell!.setup()
                    
                    let expectedValue = "\(self.validRestaurant!.distance!) miles(s)" + 
																				" from \(self.validRestaurant!.tubeStation!)"
                    expect(self.restaurantDistanceLabelStub!.text).to(equal(expectedValue))
                }
            }
        }
        
  }

}
```

