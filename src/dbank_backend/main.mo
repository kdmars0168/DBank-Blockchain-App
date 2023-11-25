import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Int "mo:base/Int";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank {
  stable var currentValue : Float = 300;
  // currentValue := 300;
  Debug.print(debug_show (currentValue));

  stable var startTime = Time.now();
  // startTime := Time.now();
  Debug.print(debug_show (startTime));

  public func topUp(amount : Float) {
    currentValue += amount;
    // Debug.print(debug_show(currentValue));
  };

  public func withdraw(amount : Float) {
    var tempvalue : Float = currentValue -amount;
    if (tempvalue >= 0) {
      currentValue -= amount;
      Debug.print(debug_show (currentValue));
    } else {
      Debug.print("Amount greater than available balance");
    };
  };

  public query func checkBalance() : async Float {
    return currentValue;
  };

  public func compound() {
    let presentTime = Time.now();
    let timeElapsedMS = presentTime - startTime;
    let timeElapsedS = timeElapsedMS / 1000_000_000;
    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedS));
    startTime := presentTime;
  };

  // topUp();
};
