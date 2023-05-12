import HashMap "mo:base/HashMap";
import Text "mo:base/Text";
import Principal "mo:base/Principal";
import Array "mo:base/Array";
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Iter "mo:base/Iter";

actor ActivitiesCalendar {

  type User = Principal;
  
  type Info = {
    hora : Text;
    desc : Text;
    Nota : Text;
  };

  type Activity = HashMap.HashMap<Text, Info>;

  
  var calendar = HashMap.HashMap<User, Activity>(32, Principal.equal, Principal.hash);

  //funcion para obtener el usuario que realiza el llamado
  public shared(msg) func getUser() : async Principal {
    let currentUser = msg.caller;
    return currentUser;
  };
  
  //funcion para agregar y actualizar las actividades de un usuario
  public shared (msg) func saveActivity(year : Nat, month: Nat, day: Nat, info: Info) : async Info {
    let user : Principal = msg.caller;
    let fecha : Text = Nat.toText(day) #"/"# Nat.toText(month) #"/"# Nat.toText(year);

    let resultActivity = calendar.get(user);

    var finalActivity : Activity = switch resultActivity {
      case (null) {
        HashMap.HashMap(32, Text.equal, Text.hash);
      };
      case (?resultActivity) resultActivity;
    };

    finalActivity.put(fecha, info);

    calendar.put(user, finalActivity);

    Debug.print("Tu actividad fue agregada correctamente " # Principal.toText(user) # "gracias! :)");
    return info;
  };

  //funcion para remover una actividad en espesifico del usuario
  public shared (msg) func removeActivity(year : Nat, month: Nat, day: Nat) {
    let user : Principal = msg.caller;
    let resultActivity = calendar.get(user);
    let fecha : Text = Nat.toText(day) #"/"# Nat.toText(month) #"/"# Nat.toText(year);

    var finalActivity : Activity = switch resultActivity {
      case (null) {
        HashMap.HashMap<Text, Info>(0, Text.equal, Text.hash);
      };
      case (?resultActivity) resultActivity;
    };

    let resultDelete = finalActivity.delete(fecha);

    calendar.put(user, finalActivity);

    Debug.print("Tu actividad fue eliminada correctamente " # fecha);

  };

  //funcion para remover todas las actividades
  public shared (msg) func removeAllActivitys() {
    let user : Principal = msg.caller;
    let result = calendar.delete(user);

    Debug.print("Tu actividad fue agregada correctamente " # Principal.toText(user) # "gracias! :)");
  };

  //funcion para consultar todas las actividades de un usuario
  public query func getActivitys(user : User) : async [(Text,Info)] {
    let result = calendar.get(user);

    var finalResult : Activity = switch result {
      case (null) {
        HashMap.HashMap<Text, Info>(0, Text.equal, Text.hash);
      };
      case (?result) result;
    };
    
    return Iter.toArray<(Text, Info)>(finalResult.entries());
  };

  //funcion para consultar una actividad en espesifico
  public query func getActivity(user : User, year : Nat, month: Nat, day: Nat) : async Info {
    let resultActivity = calendar.get(user);
    let fecha : Text = Nat.toText(day) #"/"# Nat.toText(month) #"/"# Nat.toText(year);

    var finalActivity : Activity = switch resultActivity {
      case (null) {
        HashMap.HashMap<Text, Info>(0, Text.equal, Text.hash);
      };
      case (?resultActivity) resultActivity;
    };

    let resultInfo = finalActivity.get(fecha);

    var finalInfo : Info = switch resultInfo {
      case (null) {
        {
          hora = "";
          desc = "";
          Nota = "";
        };
      };
      case (?resultInfo) resultInfo;
    };

    return finalInfo;
  };


};
