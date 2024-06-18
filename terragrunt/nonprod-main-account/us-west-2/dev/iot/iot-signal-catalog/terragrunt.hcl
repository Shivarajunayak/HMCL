# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform and OpenTofu that helps keep your code DRY and
# maintainable: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

# Include the root `terragrunt.hcl` configuration. The root configuration contains settings that are common across all
# components and environments, such as how to configure remote state.

include "root" {
  path = find_in_parent_folders()
}


# Configure the version of the module to use in this environment. This allows you to promote new versions one
# environment at a time (e.g., qa -> stage -> prod).

terraform {
  source = "git@ssh.dev.azure.com:v3/hero-ev-team/CVPI%20-%20Thor%20Infra%20DevOps/thor-infra-terraform-modules//modules/iot/iot-signal-catalog?ref=feature_iot"
}

locals {
  # Automatically load account-level variables
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))



  # Extract the variables we need for easy access

  aws_account_id   = local.account_vars.locals.aws_account_id
  aws_account_name = local.account_vars.locals.account_name
  aws_region       = local.region_vars.locals.aws_region
  aws_region_short = local.region_vars.locals.aws_region_short
  sso_region       = local.region_vars.locals.sso_region
  deployment_role  = local.account_vars.locals.deployment_role
  environment      = local.environment_vars.locals.environment

}


# Inputs to the source Terraform module

inputs = {

  fleetwise_endpoint_url = "https://controlplane.us-west-2.gamma.kaleidoscope.iot.aws.dev"
  aws_region             = "${local.aws_region}"
  terraform_role_arn     = "arn:aws:iam::${local.aws_account_id}:role/${local.deployment_role}"
  signal_catalog_name    = "hmcl-cv-nonprod-signal-catalog"

  signal_catalog_json = {
    "nodes" : [
      {
        "branch" : {
          "fullyQualifiedName" : "TestVehicle"
        }
      },
      {
        "branch" : {
          "fullyQualifiedName" : "Vehicle",
          "description" : "Vehicle"
        }
      },
      {
        "branch" : {
          "fullyQualifiedName" : "TestVehicle.Chassis"
        }
      },
      {
        "branch" : {
          "fullyQualifiedName" : "TestVehicle.CurrentLocation"
        }
      },
      {
        "branch" : {
          "fullyQualifiedName" : "TestVehicle.Exterior"
        }
      },
      {
        "branch" : {
          "fullyQualifiedName" : "TestVehicle.OBD"
        }
      },
      {
        "branch" : {
          "fullyQualifiedName" : "TestVehicle.Powertrain"
        }
      },
      {
        "branch" : {
          "fullyQualifiedName" : "TestVehicle.Chassis.Accelerator"
        }
      },
      {
        "branch" : {
          "fullyQualifiedName" : "TestVehicle.Chassis.Brake"
        }
      },
      {
        "branch" : {
          "fullyQualifiedName" : "TestVehicle.Powertrain.CombustionEngine"
        }
      },
      {
        "branch" : {
          "fullyQualifiedName" : "TestVehicle.Powertrain.TractionBattery"
        }
      },
      {
        "branch" : {
          "fullyQualifiedName" : "TestVehicle.Powertrain.Transmission"
        }
      },
      {
        "branch" : {
          "fullyQualifiedName" : "TestVehicle.Powertrain.TractionBattery.Charging"
        }
      },
      {
        "branch" : {
          "fullyQualifiedName" : "TestVehicle.Powertrain.TractionBattery.StateOfCharge"
        }
      },
      {
        "branch" : {
          "fullyQualifiedName" : "Vehicle.ABS"
        }
      },
      {
        "branch" : {
          "fullyQualifiedName" : "Vehicle.Alert"
        }
      },
      {
        "branch" : {
          "fullyQualifiedName" : "Vehicle.ECM"
        }
      },
      {
        "branch" : {
          "fullyQualifiedName" : "Vehicle.ExampleSomeipInterface",
          "description" : "Vehicle.ExampleSomeipInterface"
        }
      },
      {
        "branch" : {
          "fullyQualifiedName" : "Vehicle.Handle"
        }
      },
      {
        "branch" : {
          "fullyQualifiedName" : "Vehicle.Lights"
        }
      },
      {
        "branch" : {
          "fullyQualifiedName" : "Vehicle.OBD",
          "description" : "OBD"
        }
      },
      {
        "branch" : {
          "fullyQualifiedName" : "Vehicle.Powertrain"
        }
      },
      {
        "branch" : {
          "fullyQualifiedName" : "Vehicle.Trunk"
        }
      },
      {
        "branch" : {
          "fullyQualifiedName" : "Vehicle.ExampleSomeipInterface.A1",
          "description" : "Vehicle.ExampleSomeipInterface.A1"
        }
      },
      {
        "branch" : {
          "fullyQualifiedName" : "Vehicle.ExampleSomeipInterface.A1.A2",
          "description" : "Vehicle.ExampleSomeipInterface.A1.A2"
        }
      },
      {
        "attribute" : {
          "fullyQualifiedName" : "tenantId",
          "dataType" : "STRING"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "TestVehicle.IgnitionRelayStatus",
          "dataType" : "INT8",
          "description" : "Ignition Relay Status",
          "unit" : "",
          "min" : 0.0,
          "max" : 1.0
        }
      },
      {
        "actuator" : {
          "fullyQualifiedName" : "TestVehicle.Immobilization",
          "dataType" : "BOOLEAN",
          "description" : "TestVehicle Immobilization"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "TestVehicle.SoCUser",
          "dataType" : "FLOAT",
          "description" : "SoC User",
          "unit" : "%",
          "min" : 0.0,
          "max" : 100.0
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "TestVehicle.Speed",
          "dataType" : "FLOAT",
          "description" : "TestVehicle speed.",
          "unit" : "m/s",
          "min" : 0.0,
          "max" : 127.96875
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "TestVehicle.TraveledDistance",
          "dataType" : "DOUBLE",
          "description" : "Odometer reading, total distance traveled during the lifetime of the TestVehicle.",
          "unit" : "m",
          "min" : 0.0,
          "max" : 999999000.0
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "TestVehicle.TripDuration",
          "dataType" : "DOUBLE",
          "description" : "Duration of latest trip.",
          "unit" : "sec",
          "min" : 0.0,
          "max" : 3600000.0
        }
      },
      {
        "actuator" : {
          "fullyQualifiedName" : "TestVehicle.TripMeterReading",
          "dataType" : "FLOAT",
          "description" : "Trip meter reading.",
          "unit" : "Km",
          "min" : 0.0,
          "max" : 9999.9
        }
      },
      {
        "attribute" : {
          "fullyQualifiedName" : "TestVehicle.tenantId",
          "dataType" : "STRING"
        }
      },
      {
        "attribute" : {
          "fullyQualifiedName" : "TestVehicle.virtualId",
          "dataType" : "STRING"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "TestVehicle.Chassis.Accelerator.PedalPosition",
          "dataType" : "FLOAT",
          "description" : "Accelerator pedal position as percent. 0 = Not depressed. 100 = Fully depressed.",
          "unit" : "%",
          "min" : 0.0,
          "max" : 100.0
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "TestVehicle.Chassis.Brake.PedalPosition",
          "dataType" : "FLOAT",
          "description" : "Brake pedal position as percent. 0 = Not depressed. 100 = Fully depressed.",
          "unit" : "%",
          "min" : 0.0,
          "max" : 100.0
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "TestVehicle.CurrentLocation.Latitude",
          "dataType" : "DOUBLE",
          "description" : "Current latitude of TestVehicle in WGS 84 geodetic coordinates, as measured at the position of GNSS receiver antenna.",
          "min" : 0.0,
          "max" : 99.999999
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "TestVehicle.CurrentLocation.Longitude",
          "dataType" : "DOUBLE",
          "description" : "Current longitude of TestVehicle in WGS 84 geodetic coordinates, as measured at the position of GNSS receiver antenna.",
          "min" : 0.0,
          "max" : 99.999999
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "TestVehicle.Exterior.AirTemperature",
          "dataType" : "FLOAT",
          "description" : "Air temperature outside the TestVehicle.",
          "min" : 0.0,
          "max" : 50.0
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "TestVehicle.OBD.EngineSpeed",
          "dataType" : "FLOAT",
          "description" : "PID 0C - Engine speed measured as rotations per minute",
          "unit" : "rpm",
          "min" : 0.0,
          "max" : 16383.0
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "TestVehicle.Powertrain.CombustionEngine.IsRunning",
          "dataType" : "INT8",
          "description" : "Engine Running. True if engine is rotating (Speed > 0).",
          "min" : 0.0,
          "max" : 7.0
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "TestVehicle.Powertrain.CombustionEngine.Torque",
          "dataType" : "FLOAT",
          "description" : "Current engine torque. Shall be reported as 0 during engine breaking.",
          "unit" : "Nm",
          "min" : -2048.0,
          "max" : 2047.75
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "TestVehicle.Powertrain.TractionBattery.StateOfHealth",
          "dataType" : "INT8",
          "description" : "Calculated battery state of health at standard conditions.",
          "min" : 0.0,
          "max" : 1.0
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "TestVehicle.Powertrain.TractionBattery.Charging.ChargeType",
          "dataType" : "INT8",
          "description" : "3 AC Fast Charging, 2 V2V/V2L 1, Fast Charging, 0 Normal Charging",
          "min" : 0.0,
          "max" : 3.0
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "TestVehicle.Powertrain.TractionBattery.Charging.IsCharging",
          "dataType" : "INT8",
          "description" : "7 Reserved, 6 Reserved, 5 Reserved, 4 Charger Connection lamp Red color  Blink, 3 Charger Connection lamp Red color  ON, 2 Charger Connection lamp Green color  Blink, 1 Charger Connection lamp Green color  ON, 0 Charger Connection lamp is OFF.",
          "min" : 0.0,
          "max" : 7.0
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "TestVehicle.Powertrain.TractionBattery.Charging.IsDischarging",
          "dataType" : "INT8",
          "description" : "7 Reserved for Future Use, 6 Reserved for Future Use, 5 Reserved for Future Use, 4 Charger Connection lamp Red colour Blink, 3 Charger Connection lamp Red colour On, 2 Charger Connection lamp Amber colour Blink, 1 Charger Connection lamp Amber colour On, 0 Charger Connection lamp is OFF",
          "min" : 0.0,
          "max" : 7.0
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "TestVehicle.Powertrain.TractionBattery.StateOfCharge.Displayed",
          "dataType" : "FLOAT",
          "description" : "State of charge displayed to the customer.",
          "unit" : "%",
          "min" : 0.0,
          "max" : 100.0
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "TestVehicle.Powertrain.Transmission.CurrentGear",
          "dataType" : "INT8",
          "description" : "15 Reserved 14 Reserved 13 Reserved 12 Reserved 11 Reserved 10 Reserved 9 Reserved 8 Reverse Gear 7 Sixth Gear 6 Fifth Gear 5 Fourth Gear 4 Third Gear 3 Second Gear 2 First Gear 1 No gear engaged neutral 0 Invalid Gear",
          "min" : 0.0,
          "max" : 15.0
        }
      },
      {
        "attribute" : {
          "fullyQualifiedName" : "Vehicle.Color",
          "dataType" : "STRING",
          "description" : "Color",
          "defaultValue" : "Red"
        }
      },
      {
        "actuator" : {
          "fullyQualifiedName" : "Vehicle.Immobilization",
          "dataType" : "BOOLEAN",
          "description" : "Vehicle Immobilization"
        }
      },
      {
        "actuator" : {
          "fullyQualifiedName" : "Vehicle.Immobilize",
          "dataType" : "INT32",
          "description" : "Vehicle.Immobilize"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.Speed",
          "dataType" : "FLOAT",
          "description" : "Vehicle speed.",
          "unit" : "m/s",
          "min" : 0.0,
          "max" : 127.96875
        }
      },
      {
        "attribute" : {
          "fullyQualifiedName" : "Vehicle.TenantId",
          "dataType" : "STRING",
          "description" : "Tenant ID"
        }
      },
      {
        "attribute" : {
          "fullyQualifiedName" : "Vehicle.VirtualId",
          "dataType" : "STRING",
          "description" : "Virtual ID"
        }
      },
      {
        "actuator" : {
          "fullyQualifiedName" : "Vehicle.actuator1",
          "dataType" : "INT32",
          "description" : "Vehicle actuator1"
        }
      },
      {
        "actuator" : {
          "fullyQualifiedName" : "Vehicle.actuator2",
          "dataType" : "INT64",
          "description" : "Vehicle actuator2"
        }
      },
      {
        "actuator" : {
          "fullyQualifiedName" : "Vehicle.actuator3",
          "dataType" : "BOOLEAN",
          "description" : "Vehicle actuator3"
        }
      },
      {
        "actuator" : {
          "fullyQualifiedName" : "Vehicle.actuator4",
          "dataType" : "FLOAT",
          "description" : "Vehicle actuator4"
        }
      },
      {
        "actuator" : {
          "fullyQualifiedName" : "Vehicle.actuator5",
          "dataType" : "DOUBLE",
          "description" : "Vehicle actuator5"
        }
      },
      {
        "attribute" : {
          "fullyQualifiedName" : "Vehicle.tenantId",
          "dataType" : "STRING",
          "description" : "Vehicle.tenantId"
        }
      },
      {
        "attribute" : {
          "fullyQualifiedName" : "Vehicle.virtualId",
          "dataType" : "STRING",
          "description" : "Vehicle.tenantId"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.ABS.DemoBrakePedalPressure",
          "dataType" : "DOUBLE",
          "unit" : "kPa",
          "min" : 0.0,
          "max" : 19125.0
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.Alert.BatteryUnplugged",
          "dataType" : "INT32",
          "description" : "Vehicle.Alert.BatteryUnplugged",
          "min" : 0.0,
          "max" : 1.0
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.Alert.Crash",
          "dataType" : "INT32",
          "description" : "Vehicle.Alert.Crash",
          "min" : 0.0,
          "max" : 1.0
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.Alert.DTCAlert",
          "dataType" : "INT32",
          "description" : "Vehicle.Alert.DTCAlert",
          "min" : 0.0,
          "max" : 1.0
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.Alert.FallDown",
          "dataType" : "INT32",
          "description" : "Vehicle.Alert.FallDown",
          "min" : 0.0,
          "max" : 1.0
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.Alert.HarshDriving",
          "dataType" : "INT32",
          "description" : "Vehicle.Alert.HarshDriving",
          "min" : 0.0,
          "max" : 1.0
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.Alert.Ignition",
          "dataType" : "INT32",
          "description" : "Vehicle.Alert.Ignition",
          "min" : 0.0,
          "max" : 1.0
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.Alert.Panic",
          "dataType" : "INT32",
          "description" : "Vehicle.Alert.Panic",
          "min" : 0.0,
          "max" : 1.0
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.Alert.Theft",
          "dataType" : "INT32",
          "description" : "Vehicle.Alert.Theft",
          "min" : 0.0,
          "max" : 1.0
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.Alert.Tow",
          "dataType" : "INT32",
          "description" : "Vehicle.Alert.Tow",
          "min" : 0.0,
          "max" : 1.0
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.ECM.DemoEngineTorque",
          "dataType" : "DOUBLE",
          "unit" : "Nm",
          "min" : -848.0,
          "max" : 1199.5
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.ExampleSomeipInterface.X",
          "dataType" : "INT32",
          "description" : "Vehicle.ExampleSomeipInterface.X"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.ExampleSomeipInterface.A1.A2.A",
          "dataType" : "INT32",
          "description" : "Vehicle.ExampleSomeipInterface.A1.A2.A"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.ExampleSomeipInterface.A1.A2.B",
          "dataType" : "BOOLEAN",
          "description" : "Vehicle.ExampleSomeipInterface.A1.A2.B"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.ExampleSomeipInterface.A1.A2.D",
          "dataType" : "DOUBLE",
          "description" : "Vehicle.ExampleSomeipInterface.A1.A2.D"
        }
      },
      {
        "actuator" : {
          "fullyQualifiedName" : "Vehicle.Handle.Lock",
          "dataType" : "INT32",
          "description" : "Vehicle.Handle.Lock"
        }
      },
      {
        "actuator" : {
          "fullyQualifiedName" : "Vehicle.Lights.FollowMeHome",
          "dataType" : "INT32",
          "description" : "Vehicle.Lights.FollowMeHome"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.AbsoluteLoad",
          "dataType" : "DOUBLE",
          "description" : "PID 43 - Absolute load value",
          "unit" : "percent"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.AbsoluteThrottlePositionG",
          "dataType" : "DOUBLE",
          "description" : "Throttle Position G"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.AcceleratorPositionD",
          "dataType" : "DOUBLE",
          "description" : "PID 49 - Accelerator pedal position D",
          "unit" : "percent"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.AcceleratorPositionE",
          "dataType" : "DOUBLE",
          "description" : "PID 4A - Accelerator pedal position E",
          "unit" : "percent"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.AcceleratorPositionF",
          "dataType" : "DOUBLE",
          "description" : "PID 4B - Accelerator pedal position F",
          "unit" : "percent"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.ActualEgrA",
          "dataType" : "DOUBLE",
          "description" : "Commanded EGR and EGR Error"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.ActualEgrB",
          "dataType" : "DOUBLE",
          "description" : "Commanded EGR and EGR Error"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.ActualEngineTorque",
          "dataType" : "DOUBLE",
          "description" : "Actual engine - percent torque"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.AmbientAirTemperature",
          "dataType" : "DOUBLE",
          "description" : "PID 46 - Ambient air temperature",
          "unit" : "celsius"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.AvgDemandedReagentConsumption",
          "dataType" : "DOUBLE",
          "description" : "NOx reagent system"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.AvgReagentConsumption",
          "dataType" : "DOUBLE",
          "description" : "NOx reagent system"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.Bank1Catalyst",
          "dataType" : "DOUBLE",
          "description" : "PID 3E - Catalyst temperature from bank 1, sensor 2",
          "unit" : "celsius"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.Bank2Catalyst",
          "dataType" : "DOUBLE",
          "description" : "PID 3F - Catalyst temperature from bank 2, sensor 2",
          "unit" : "celsius"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.BarometricPressure",
          "dataType" : "DOUBLE",
          "description" : "PID 33 - Barometric pressure",
          "unit" : "kPa"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.BoostPressureA",
          "dataType" : "DOUBLE",
          "description" : "Boost pressure control"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.BoostPressureB",
          "dataType" : "DOUBLE",
          "description" : "Boost pressure control"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.BoostPressureControlSupport",
          "dataType" : "DOUBLE",
          "description" : "Boost pressure control"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.CACTBank1Sensor1",
          "dataType" : "DOUBLE",
          "description" : "Charge air cooler temperature (CACT)"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.CACTBank1Sensor2",
          "dataType" : "DOUBLE",
          "description" : "Charge air cooler temperature (CACT)"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.CACTBank2Sensor1",
          "dataType" : "DOUBLE",
          "description" : "Charge air cooler temperature (CACT)"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.CACTBank2Sensor2",
          "dataType" : "DOUBLE",
          "description" : "Charge air cooler temperature (CACT)"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.CACTSupport",
          "dataType" : "DOUBLE",
          "description" : "Charge air cooler temperature (CACT)"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.CommandedBoostPressureA",
          "dataType" : "DOUBLE",
          "description" : "Boost pressure control"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.CommandedBoostPressureB",
          "dataType" : "DOUBLE",
          "description" : "Boost pressure control"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.CommandedEgrA",
          "dataType" : "DOUBLE",
          "description" : "Commanded EGR and EGR Error"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.CommandedEgrB",
          "dataType" : "DOUBLE",
          "description" : "Commanded EGR and EGR Error"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.CommandedEquivalenceRatio",
          "dataType" : "DOUBLE",
          "description" : "PID 44 - Commanded equivalence ratio",
          "unit" : "ratio"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.CommandedFuelRailPressureA",
          "dataType" : "DOUBLE",
          "description" : "Fuel pressure control system"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.CommandedFuelRailPressureB",
          "dataType" : "DOUBLE",
          "description" : "Fuel pressure control system"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.CommandedInjectionControlPressureA",
          "dataType" : "DOUBLE",
          "description" : "Injection pressure control system"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.CommandedInjectionControlPressureB",
          "dataType" : "DOUBLE",
          "description" : "Injection pressure control system"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.CommandedIntakeAirFlowA",
          "dataType" : "DOUBLE",
          "description" : "Commanded Diesel intake air flow control and relative intake air flow"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.CommandedIntakeAirFlowB",
          "dataType" : "DOUBLE",
          "description" : "Commanded Diesel intake air flow control and relative intake air flow"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.CommandedThrottleActuatorA",
          "dataType" : "DOUBLE",
          "description" : "Commanded throttle actuator control and relative throttle position"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.CommandedThrottleActuatorB",
          "dataType" : "DOUBLE",
          "description" : "Commanded throttle actuator control and relative throttle position"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.CommandedVgtAPosition",
          "dataType" : "DOUBLE",
          "description" : "Variable Geometry turbo (VGT) control"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.CommandedVgtBPosition",
          "dataType" : "DOUBLE",
          "description" : "Variable Geometry turbo (VGT) control"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.CommandedWastegateAPosition",
          "dataType" : "DOUBLE",
          "description" : "Wastegate control"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.CommandedWastegateBPosition",
          "dataType" : "DOUBLE",
          "description" : "Wastegate control"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.ControlModuleVoltage",
          "dataType" : "DOUBLE",
          "description" : "PID 42 - Control module voltage",
          "unit" : "V"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.CoolantTemperature",
          "dataType" : "DOUBLE",
          "description" : "PID 05 - Coolant temperature",
          "unit" : "celsius"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.CumulativeMICounter",
          "dataType" : "DOUBLE",
          "description" : "WWH-OBD Vehicle OBD Counters support"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.CylinderFuelRate",
          "dataType" : "DOUBLE",
          "description" : "Cylinder Fuel Rate"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.DEFConcentration",
          "dataType" : "DOUBLE",
          "description" : "Diesel Exhaust Fluid Sensor Data"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.DEFSupport",
          "dataType" : "DOUBLE",
          "description" : "Diesel Exhaust Fluid Sensor Data"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.DEFTankLevel",
          "dataType" : "DOUBLE",
          "description" : "Diesel Exhaust Fluid Sensor Data"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.DEFTankTemperature",
          "dataType" : "DOUBLE",
          "description" : "Diesel Exhaust Fluid Sensor Data"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.DemandEngineTorque",
          "dataType" : "DOUBLE",
          "description" : "Driver's demand engine - percent torque"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.DistanceSinceDTCClear",
          "dataType" : "DOUBLE",
          "description" : "PID 31 - Distance traveled since codes cleared",
          "unit" : "km"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.DistanceWithMIL",
          "dataType" : "DOUBLE",
          "description" : "PID 21 - Distance traveled with MIL on",
          "unit" : "km"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.DosingActivityCounter",
          "dataType" : "DOUBLE",
          "description" : "NOx Warning And Inducement System"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EGRError",
          "dataType" : "DOUBLE",
          "description" : "PID 2D - Exhaust gas recirculation (EGR) error",
          "unit" : "percent"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EGRSupport",
          "dataType" : "DOUBLE",
          "description" : "Commanded EGR and EGR Error"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EGRTempBank1Sensor1",
          "dataType" : "DOUBLE",
          "description" : "Exhaust gas recirculation temperature"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EGRTempBank1Sensor2",
          "dataType" : "DOUBLE",
          "description" : "Exhaust gas recirculation temperature"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EGRTempBank2Sensor1",
          "dataType" : "DOUBLE",
          "description" : "Exhaust gas recirculation temperature"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EGRTempBank2Sensor2",
          "dataType" : "DOUBLE",
          "description" : "Exhaust gas recirculation temperature"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EGRTempSupported",
          "dataType" : "DOUBLE",
          "description" : "Exhaust gas recirculation temperature"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EGRValveCounter",
          "dataType" : "DOUBLE",
          "description" : "NOx Warning And Inducement System"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EGTBank1Sensor1",
          "dataType" : "DOUBLE",
          "description" : "Exhaust Gas temperature (EGT) Bank 1"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EGTBank1Sensor2",
          "dataType" : "DOUBLE",
          "description" : "Exhaust Gas temperature (EGT) Bank 1"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EGTBank1Sensor3",
          "dataType" : "DOUBLE",
          "description" : "Exhaust Gas temperature (EGT) Bank 1"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EGTBank1Sensor4",
          "dataType" : "DOUBLE",
          "description" : "Exhaust Gas temperature (EGT) Bank 1"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EGTBank1Sensor5",
          "dataType" : "DOUBLE",
          "description" : "Exhaust Gas Temperature Sensor"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EGTBank1Sensor6",
          "dataType" : "DOUBLE",
          "description" : "Exhaust Gas Temperature Sensor"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EGTBank1Sensor7",
          "dataType" : "DOUBLE",
          "description" : "Exhaust Gas Temperature Sensor"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EGTBank1Sensor8",
          "dataType" : "DOUBLE",
          "description" : "Exhaust Gas Temperature Sensor"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EGTBank1Support",
          "dataType" : "DOUBLE",
          "description" : "Exhaust Gas temperature (EGT) Bank 1"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EGTBank1SupportHigherSensors",
          "dataType" : "DOUBLE",
          "description" : "Exhaust Gas Temperature Sensor"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EGTBank2Sensor1",
          "dataType" : "DOUBLE",
          "description" : "Exhaust Gas temperature (EGT) Bank 2"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EGTBank2Sensor2",
          "dataType" : "DOUBLE",
          "description" : "Exhaust Gas temperature (EGT) Bank 2"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EGTBank2Sensor3",
          "dataType" : "DOUBLE",
          "description" : "Exhaust Gas temperature (EGT) Bank 2"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EGTBank2Sensor4",
          "dataType" : "DOUBLE",
          "description" : "Exhaust Gas temperature (EGT) Bank 2"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EGTBank2Sensor5",
          "dataType" : "DOUBLE",
          "description" : "Exhaust Gas Temperature Sensor"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EGTBank2Sensor6",
          "dataType" : "DOUBLE",
          "description" : "Exhaust Gas Temperature Sensor"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EGTBank2Sensor7",
          "dataType" : "DOUBLE",
          "description" : "Exhaust Gas Temperature Sensor"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EGTBank2Sensor8",
          "dataType" : "DOUBLE",
          "description" : "Exhaust Gas Temperature Sensor"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EGTBank2Support",
          "dataType" : "DOUBLE",
          "description" : "Exhaust Gas temperature (EGT) Bank 2"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EGTBank2SupportHigherSensors",
          "dataType" : "DOUBLE",
          "description" : "Exhaust Gas Temperature Sensor"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EVAPVaporPressure",
          "dataType" : "DOUBLE",
          "description" : "PID 32 - Evaporative purge (EVAP) system pressure",
          "unit" : "Pa"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EngineCoolantTemperature",
          "dataType" : "DOUBLE",
          "description" : "Engine coolant temperature"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EngineCoolantTemperature1",
          "dataType" : "DOUBLE",
          "description" : "Engine coolant temperature"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EngineCoolantTemperature2",
          "dataType" : "DOUBLE",
          "description" : "Engine coolant temperature"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EngineExhaustFlowRate",
          "dataType" : "DOUBLE",
          "description" : "Engine Exhaust Flow Rate"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EngineFriction",
          "dataType" : "DOUBLE",
          "description" : "Engine Friction - Percent Torque"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EngineFuelRate",
          "dataType" : "DOUBLE",
          "description" : "Engine Fuel Rate"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EngineIdleTime",
          "dataType" : "DOUBLE",
          "description" : "Engine idle time"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EngineLoad",
          "dataType" : "DOUBLE",
          "description" : "PID 04 - Engine load in percent - 0 = no load, 100 = full load",
          "unit" : "percent",
          "min" : 0.0,
          "max" : 100.0
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EngineRunTime",
          "dataType" : "DOUBLE",
          "description" : "Engine run time"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EngineRunTimePTOActive",
          "dataType" : "DOUBLE",
          "description" : "Engine run time"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EngineRunTimeSupport",
          "dataType" : "DOUBLE",
          "description" : "Engine run time"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EngineRuneTimeWithNOxWarning",
          "dataType" : "DOUBLE",
          "description" : "NOx reagent system"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EngineSpeed",
          "dataType" : "DOUBLE",
          "description" : "PID 0C - Engine speed measured as rotations per minute",
          "unit" : "rpm"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EngineTorquePoint1",
          "dataType" : "DOUBLE",
          "description" : "Engine percent torque data"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EngineTorquePoint2",
          "dataType" : "DOUBLE",
          "description" : "Engine percent torque data"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EngineTorquePoint3",
          "dataType" : "DOUBLE",
          "description" : "Engine percent torque data"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EngineTorquePoint4",
          "dataType" : "DOUBLE",
          "description" : "Engine percent torque data"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EngineTorquePointIdle",
          "dataType" : "DOUBLE",
          "description" : "Engine percent torque data"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.ErrorEgrA",
          "dataType" : "DOUBLE",
          "description" : "Commanded EGR and EGR Error"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.ErrorEgrB",
          "dataType" : "DOUBLE",
          "description" : "Commanded EGR and EGR Error"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.EthanolPercent",
          "dataType" : "DOUBLE",
          "description" : "PID 52 - Percentage of ethanol in the fuel",
          "unit" : "percent"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.ExhaustPressureBank1",
          "dataType" : "DOUBLE",
          "description" : "Exhaust pressure"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.ExhaustPressureBank2",
          "dataType" : "DOUBLE",
          "description" : "Exhaust pressure"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.ExhaustPressureSupport",
          "dataType" : "DOUBLE",
          "description" : "Exhaust pressure"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.FuelInjectionTiming",
          "dataType" : "DOUBLE",
          "description" : "PID 5D - Fuel injection timing",
          "unit" : "degrees"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.FuelLevel",
          "dataType" : "DOUBLE",
          "description" : "PID 2F - Fuel level in the fuel tank",
          "unit" : "percent"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.FuelPercentageUseSystemABank1",
          "dataType" : "DOUBLE",
          "description" : "Fuel System Percentage Use"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.FuelPercentageUseSystemABank2",
          "dataType" : "DOUBLE",
          "description" : "Fuel System Percentage Use"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.FuelPercentageUseSystemABank3",
          "dataType" : "DOUBLE",
          "description" : "Fuel System Percentage Use"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.FuelPercentageUseSystemABank4",
          "dataType" : "DOUBLE",
          "description" : "Fuel System Percentage Use"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.FuelPercentageUseSystemBBank1",
          "dataType" : "DOUBLE",
          "description" : "Fuel System Percentage Use"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.FuelPercentageUseSystemBBank2",
          "dataType" : "DOUBLE",
          "description" : "Fuel System Percentage Use"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.FuelPercentageUseSystemBBank3",
          "dataType" : "DOUBLE",
          "description" : "Fuel System Percentage Use"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.FuelPercentageUseSystemBBank4",
          "dataType" : "DOUBLE",
          "description" : "Fuel System Percentage Use"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.FuelPressure",
          "dataType" : "DOUBLE",
          "description" : "PID 0A - Fuel pressure",
          "unit" : "kPa",
          "min" : 0.0
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.FuelPressureControlSupport",
          "dataType" : "DOUBLE",
          "description" : "Fuel pressure control system"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.FuelRailPressureA",
          "dataType" : "DOUBLE",
          "description" : "Fuel pressure control system"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.FuelRailPressureAbsolute",
          "dataType" : "DOUBLE",
          "description" : "PID 59 - Absolute fuel rail pressure",
          "unit" : "kPa"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.FuelRailPressureB",
          "dataType" : "DOUBLE",
          "description" : "Fuel pressure control system"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.FuelRailPressureDirect",
          "dataType" : "DOUBLE",
          "description" : "PID 23 - Fuel rail pressure direct inject",
          "unit" : "kPa"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.FuelRailPressureVac",
          "dataType" : "DOUBLE",
          "description" : "PID 22 - Fuel rail pressure relative to vacuum",
          "unit" : "kPa"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.FuelRailTemperatureA",
          "dataType" : "DOUBLE",
          "description" : "Fuel pressure control system"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.FuelRailTemperatureB",
          "dataType" : "DOUBLE",
          "description" : "Fuel pressure control system"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.FuelRate",
          "dataType" : "DOUBLE",
          "description" : "PID 5E - Engine fuel rate",
          "unit" : "l/h"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.FuelStatus",
          "dataType" : "DOUBLE",
          "description" : "PID 03 - Fuel status"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.FuelSystemPercentageUseSupport",
          "dataType" : "DOUBLE",
          "description" : "Fuel System Percentage Use"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.FuelSystemStatus",
          "dataType" : "DOUBLE",
          "description" : "Fuel System Control"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.FuelSystemStatusSupport",
          "dataType" : "DOUBLE",
          "description" : "Fuel System Control"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.FuelType",
          "dataType" : "DOUBLE",
          "description" : "PID 51 - Fuel type"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.HybridBatteryRemaining",
          "dataType" : "DOUBLE",
          "description" : "PID 5B - Remaining life of hybrid battery",
          "unit" : "percent"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.HybridEvCurrent",
          "dataType" : "DOUBLE",
          "description" : "Hybrid/EV Vehicle System Data, Battery, Voltage"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.HybridEvState",
          "dataType" : "DOUBLE",
          "description" : "Hybrid/EV Vehicle System Data, Battery, Voltage"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.HybridEvSupport",
          "dataType" : "DOUBLE",
          "description" : "Hybrid/EV Vehicle System Data, Battery, Voltage"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.HybridEvVoltage",
          "dataType" : "DOUBLE",
          "description" : "Hybrid/EV Vehicle System Data, Battery, Voltage"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.InjectionControlPressureA",
          "dataType" : "DOUBLE",
          "description" : "Injection pressure control system"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.InjectionControlPressureB",
          "dataType" : "DOUBLE",
          "description" : "Injection pressure control system"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.InjectionPressureControlSupport",
          "dataType" : "DOUBLE",
          "description" : "Injection pressure control system"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.IntakeAirFlowSupport",
          "dataType" : "DOUBLE",
          "description" : "Commanded Diesel intake air flow control and relative intake air flow"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.IntakeTemp",
          "dataType" : "DOUBLE",
          "description" : "PID 0F - Intake temperature",
          "unit" : "celsius"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.IntakeTemperature",
          "dataType" : "DOUBLE",
          "description" : "Intake air temperature sensor"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.IntakeTemperatureBank1Senor1",
          "dataType" : "DOUBLE",
          "description" : "Intake air temperature sensor"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.IntakeTemperatureBank1Senor2",
          "dataType" : "DOUBLE",
          "description" : "Intake air temperature sensor"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.IntakeTemperatureBank1Senor3",
          "dataType" : "DOUBLE",
          "description" : "Intake air temperature sensor"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.IntakeTemperatureBank2Senor1",
          "dataType" : "DOUBLE",
          "description" : "Intake air temperature sensor"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.IntakeTemperatureBank2Senor2",
          "dataType" : "DOUBLE",
          "description" : "Intake air temperature sensor"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.IntakeTemperatureBank2Senor3",
          "dataType" : "DOUBLE",
          "description" : "Intake air temperature sensor"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.LongTermFuelTrim1",
          "dataType" : "DOUBLE",
          "description" : "PID 07 - Long Term (learned) Fuel Trim - Bank 1 - negative percent leaner, positive percent richer",
          "unit" : "percent",
          "min" : -100.0,
          "max" : 100.0
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.LongTermFuelTrim2",
          "dataType" : "DOUBLE",
          "description" : "PID 09 - Long Term (learned) Fuel Trim - Bank 2 - negative percent leaner, positive percent richer",
          "unit" : "percent",
          "min" : -100.0,
          "max" : 100.0
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.MAF",
          "dataType" : "DOUBLE",
          "description" : "Mass air flow sensor"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.MAP",
          "dataType" : "DOUBLE",
          "description" : "PID 0B - Intake manifold pressure",
          "unit" : "kPa",
          "min" : 0.0
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.MafA",
          "dataType" : "DOUBLE",
          "description" : "Mass air flow sensor A"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.MafB",
          "dataType" : "DOUBLE",
          "description" : "Mass air flow sensor B"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.ManifoldAbsolutePressure",
          "dataType" : "DOUBLE",
          "description" : "Intake manifold absolute pressure"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.ManifoldAbsolutePressureA",
          "dataType" : "DOUBLE",
          "description" : "Intake manifold absolute pressure"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.ManifoldAbsolutePressureB",
          "dataType" : "DOUBLE",
          "description" : "Intake manifold absolute pressure"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.ManifoldSurfaceTemperature",
          "dataType" : "DOUBLE",
          "description" : "Manifold surface temperature"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.MaxEquivalenceRatio",
          "dataType" : "DOUBLE",
          "description" : "Maximum value for Fuel-Air equivalence ratio,"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.MaxIntakeMAP",
          "dataType" : "DOUBLE",
          "description" : "Maximum value for Fuel-Air equivalence ratio,"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.MaxOxygenSensorCurrent",
          "dataType" : "DOUBLE",
          "description" : "Maximum value for Fuel-Air equivalence ratio,"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.MaxOxygenSensorVoltage",
          "dataType" : "DOUBLE",
          "description" : "Maximum value for Fuel-Air equivalence ratio,"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.MonitoringSystemCounter",
          "dataType" : "DOUBLE",
          "description" : "NOx Warning And Inducement System"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.NOxReagentSupport",
          "dataType" : "DOUBLE",
          "description" : "NOx reagent system"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.NOxSensorBank1Sensor1",
          "dataType" : "DOUBLE",
          "description" : "NOx sensor"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.NOxSensorBank1Sensor2",
          "dataType" : "DOUBLE",
          "description" : "NOx sensor"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.NOxSensorBank2Sensor1",
          "dataType" : "DOUBLE",
          "description" : "NOx sensor"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.NOxSensorBank2Sensor2",
          "dataType" : "DOUBLE",
          "description" : "NOx sensor"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.NOxSensorSupport",
          "dataType" : "DOUBLE",
          "description" : "NOx sensor"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.NOxWarningAndInducementSupport",
          "dataType" : "DOUBLE",
          "description" : "NOx Warning And Inducement System"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.NTEControlAreaStatus",
          "dataType" : "DOUBLE",
          "description" : "PM NTE (Not-To-Exceed) control area status"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.NTEStatus",
          "dataType" : "DOUBLE",
          "description" : "NOx NTE (Not-To-Exceed) control area status"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.O2Bank1Sensor1",
          "dataType" : "DOUBLE",
          "description" : "PID 14 - Sensor voltage",
          "unit" : "V"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.O2Bank1Sensor2",
          "dataType" : "DOUBLE",
          "description" : "PID 15 - Sensor voltage",
          "unit" : "V"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.O2Bank1Sensor3",
          "dataType" : "DOUBLE",
          "description" : "PID 16 - Sensor voltage",
          "unit" : "V"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.O2Bank1Sensor4",
          "dataType" : "DOUBLE",
          "description" : "PID 17 - Sensor voltage",
          "unit" : "V"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.O2Bank2Sensor1",
          "dataType" : "DOUBLE",
          "description" : "PID 18 - Sensor voltage",
          "unit" : "V"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.O2Bank2Sensor2",
          "dataType" : "DOUBLE",
          "description" : "PID 19 - Sensor voltage",
          "unit" : "V"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.O2Bank2Sensor3",
          "dataType" : "DOUBLE",
          "description" : "PID 1A - Sensor voltage",
          "unit" : "V"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.O2Bank2Sensor4",
          "dataType" : "DOUBLE",
          "description" : "PID 1B - Sensor voltage",
          "unit" : "V"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.O2SensorConcentrationBank1Sensor1",
          "dataType" : "DOUBLE",
          "description" : "O2 Sensor (Wide Range)"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.O2SensorConcentrationBank1Sensor2",
          "dataType" : "DOUBLE",
          "description" : "O2 Sensor (Wide Range)"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.O2SensorConcentrationBank1Sensor3",
          "dataType" : "DOUBLE",
          "description" : "O2 Sensor Data"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.O2SensorConcentrationBank1Sensor4",
          "dataType" : "DOUBLE",
          "description" : "O2 Sensor Data"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.O2SensorConcentrationBank2Sensor1",
          "dataType" : "DOUBLE",
          "description" : "O2 Sensor (Wide Range)"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.O2SensorConcentrationBank2Sensor2",
          "dataType" : "DOUBLE",
          "description" : "O2 Sensor (Wide Range)"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.O2SensorConcentrationBank2Sensor3",
          "dataType" : "DOUBLE",
          "description" : "O2 Sensor Data"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.O2SensorConcentrationBank2Sensor4",
          "dataType" : "DOUBLE",
          "description" : "O2 Sensor Data"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.O2SensorLambdaBank1Sensor1",
          "dataType" : "DOUBLE",
          "description" : "O2 Sensor (Wide Range)"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.O2SensorLambdaBank1Sensor2",
          "dataType" : "DOUBLE",
          "description" : "O2 Sensor (Wide Range)"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.O2SensorLambdaBank1Sensor3",
          "dataType" : "DOUBLE",
          "description" : "O2 Sensor Data"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.O2SensorLambdaBank1Sensor4",
          "dataType" : "DOUBLE",
          "description" : "O2 Sensor Data"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.O2SensorLambdaBank2Sensor1",
          "dataType" : "DOUBLE",
          "description" : "O2 Sensor (Wide Range)"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.O2SensorLambdaBank2Sensor2",
          "dataType" : "DOUBLE",
          "description" : "O2 Sensor (Wide Range)"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.O2SensorLambdaBank2Sensor3",
          "dataType" : "DOUBLE",
          "description" : "O2 Sensor Data"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.O2SensorLambdaBank2Sensor4",
          "dataType" : "DOUBLE",
          "description" : "O2 Sensor Data"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.O2SensorSupport",
          "dataType" : "DOUBLE",
          "description" : "O2 Sensor (Wide Range)"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.O2Support",
          "dataType" : "DOUBLE",
          "description" : "PID 13 - Presence of oxygen sensors for the banks"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.O2SupportWideRange",
          "dataType" : "DOUBLE",
          "description" : "O2 Sensor Data"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.O2WRSensor1",
          "dataType" : "DOUBLE",
          "description" : "PID 34 - Lambda current for wide range/band oxygen sensor 1",
          "unit" : "A"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.O2WRSensor2",
          "dataType" : "DOUBLE",
          "description" : "PID 35 - Lambda current for wide range/band oxygen sensor 2",
          "unit" : "A"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.O2WRSensor3",
          "dataType" : "DOUBLE",
          "description" : "PID 36 - Lambda current for wide range/band oxygen sensor 4",
          "unit" : "A"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.O2WRSensor4",
          "dataType" : "DOUBLE",
          "description" : "PID 37 - Lambda current for wide range/band oxygen sensor 4",
          "unit" : "A"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.O2WRSensor5",
          "dataType" : "DOUBLE",
          "description" : "PID 38 - Lambda current for wide range/band oxygen sensor 5",
          "unit" : "A"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.O2WRSensor6",
          "dataType" : "DOUBLE",
          "description" : "PID 39 - Lambda current for wide range/band oxygen sensor 6",
          "unit" : "A"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.O2WRSensor7",
          "dataType" : "DOUBLE",
          "description" : "PID 3A - Lambda current for wide range/band oxygen sensor 7",
          "unit" : "A"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.O2WRSensor8",
          "dataType" : "DOUBLE",
          "description" : "PID 3B - Lambda current for wide range/band oxygen sensor 8",
          "unit" : "A"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.Odometer",
          "dataType" : "DOUBLE",
          "description" : "Odometer"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.OilTemperature",
          "dataType" : "DOUBLE",
          "description" : "PID 5C - Engine oil temperature",
          "unit" : "celsius"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.PFBank1InletTemp",
          "dataType" : "DOUBLE",
          "description" : "Diesel Particulate filter (DPF) temperature"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.PFBank1OutletTemp",
          "dataType" : "DOUBLE",
          "description" : "Diesel Particulate filter (DPF) temperature"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.PFBank2InletTemp",
          "dataType" : "DOUBLE",
          "description" : "Diesel Particulate filter (DPF) temperature"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.PFBank2OutletTemp",
          "dataType" : "DOUBLE",
          "description" : "Diesel Particulate filter (DPF) temperature"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.PMSensorBank1Sensor1",
          "dataType" : "DOUBLE",
          "description" : "Particulate matter (PM) sensor"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.PMSensorBank2Sensor1",
          "dataType" : "DOUBLE",
          "description" : "Particulate matter (PM) sensor"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.PMSensorSupport",
          "dataType" : "DOUBLE",
          "description" : "Particulate matter (PM) sensor"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.ParticulateFilterBank1DeltaPressure",
          "dataType" : "DOUBLE",
          "description" : "Diesel particulate"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.ParticulateFilterBank1InletPressure",
          "dataType" : "DOUBLE",
          "description" : "Diesel particulate"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.ParticulateFilterBank1OutletPressure",
          "dataType" : "DOUBLE",
          "description" : "Diesel particulate"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.ParticulateFilterBank1Support",
          "dataType" : "DOUBLE",
          "description" : "Diesel particulate"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.ParticulateFilterBank2DeltaPressure",
          "dataType" : "DOUBLE",
          "description" : "Diesel particulate"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.ParticulateFilterBank2InletPressure",
          "dataType" : "DOUBLE",
          "description" : "Diesel particulate"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.ParticulateFilterBank2OutletPressure",
          "dataType" : "DOUBLE",
          "description" : "Diesel particulate"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.ParticulateFilterBank2Support",
          "dataType" : "DOUBLE",
          "description" : "Diesel particulate"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.ParticulateFilterTempSupport",
          "dataType" : "DOUBLE",
          "description" : "Diesel Particulate filter (DPF) temperature"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.PidsA",
          "dataType" : "DOUBLE",
          "description" : "PID 00 - Bit array of the supported pids 01 to 20"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.PidsB",
          "dataType" : "DOUBLE",
          "description" : "PID 20 - Bit array of the supported pids 21 to 40"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.PidsC",
          "dataType" : "DOUBLE",
          "description" : "PID 40 - Bit array of the supported pids 41 to 60"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.ReagentConsumptionCounter",
          "dataType" : "DOUBLE",
          "description" : "NOx Warning And Inducement System"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.ReagentQualityCounter",
          "dataType" : "DOUBLE",
          "description" : "NOx Warning And Inducement System"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.ReagentTankLevel",
          "dataType" : "DOUBLE",
          "description" : "NOx reagent system"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.ReferenceEngineTorque",
          "dataType" : "DOUBLE",
          "description" : "Engine reference torque"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.RelativeAcceleratorPosition",
          "dataType" : "DOUBLE",
          "description" : "PID 5A - Relative accelerator pedal position",
          "unit" : "percent"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.RelativeIntakeAirFlowA",
          "dataType" : "DOUBLE",
          "description" : "Commanded Diesel intake air flow control and relative intake air flow"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.RelativeIntakeAirFlowB",
          "dataType" : "DOUBLE",
          "description" : "Commanded Diesel intake air flow control and relative intake air flow"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.RelativePositionThrottleA",
          "dataType" : "DOUBLE",
          "description" : "Commanded throttle actuator control and relative throttle position"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.RelativePositionThrottleB",
          "dataType" : "DOUBLE",
          "description" : "Commanded throttle actuator control and relative throttle position"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.RelativeThrottlePosition",
          "dataType" : "DOUBLE",
          "description" : "PID 45 - Relative throttle position",
          "unit" : "percent"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.RunTime",
          "dataType" : "DOUBLE",
          "description" : "PID 1F - Engine run time",
          "unit" : "s"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.RunTimeMIL",
          "dataType" : "DOUBLE",
          "description" : "PID 4D - Run time with MIL on",
          "unit" : "min"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.ShortTermFuelTrim1",
          "dataType" : "DOUBLE",
          "description" : "PID 06 - Short Term (immediate) Fuel Trim - Bank 1 - negative percent leaner, positive percent richer",
          "unit" : "percent",
          "min" : -100.0,
          "max" : 100.0
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.ShortTermFuelTrim2",
          "dataType" : "DOUBLE",
          "description" : "PID 08 - Short Term (immediate) Fuel Trim - Bank 2 - negative percent leaner, positive percent richer",
          "unit" : "percent",
          "min" : -100.0,
          "max" : 100.0
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.Speed",
          "dataType" : "DOUBLE",
          "description" : "PID 0D - Vehicle speed",
          "unit" : "km/h"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.SystemStatus",
          "dataType" : "DOUBLE",
          "description" : "NOx Warning And Inducement System"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.ThrottleActuatorSupport",
          "dataType" : "DOUBLE",
          "description" : "Commanded throttle actuator control and relative throttle position"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.ThrottlePosition",
          "dataType" : "DOUBLE",
          "description" : "PID 11 - Throttle position - 0 = closed throttle, 100 = open throttle",
          "unit" : "percent",
          "min" : 0.0,
          "max" : 100.0
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.ThrottlePositionB",
          "dataType" : "DOUBLE",
          "description" : "PID 47 - Absolute throttle position B",
          "unit" : "percent"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.ThrottlePositionC",
          "dataType" : "DOUBLE",
          "description" : "PID 48 - Absolute throttle position C",
          "unit" : "percent"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.TimeSinceDTCCleared",
          "dataType" : "DOUBLE",
          "description" : "PID 4E - Time since trouble codes cleared",
          "unit" : "min"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.TimingAdvance",
          "dataType" : "DOUBLE",
          "description" : "PID 0E - Time advance",
          "unit" : "degrees"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.TransmissionActualGearRatio",
          "dataType" : "DOUBLE",
          "description" : "Transmission Actual Gear"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.TransmissionActualGearStatusSupport",
          "dataType" : "DOUBLE",
          "description" : "Transmission Actual Gear"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.TurboChargerInletPressureSensorA",
          "dataType" : "DOUBLE",
          "description" : "Turbocharger compressor inlet pressure"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.TurboChargerInletPressureSensorB",
          "dataType" : "DOUBLE",
          "description" : "Turbocharger compressor inlet pressure"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.TurboChargerInletPressureSupport",
          "dataType" : "DOUBLE",
          "description" : "Turbocharger compressor inlet pressure"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.TurbochargerACompressorInletTemp",
          "dataType" : "DOUBLE",
          "description" : "Turbocharger temperature"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.TurbochargerACompressorOutletTemp",
          "dataType" : "DOUBLE",
          "description" : "Turbocharger temperature"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.TurbochargerATempSupport",
          "dataType" : "DOUBLE",
          "description" : "Turbocharger temperature"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.TurbochargerATurbineInletTemp",
          "dataType" : "DOUBLE",
          "description" : "Turbocharger temperature"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.TurbochargerATurbineOutletTemp",
          "dataType" : "DOUBLE",
          "description" : "Turbocharger temperature"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.TurbochargerArpm",
          "dataType" : "DOUBLE",
          "description" : "Turbocharger RPM"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.TurbochargerBCompressorInletTemp",
          "dataType" : "DOUBLE",
          "description" : "Turbocharger temperature"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.TurbochargerBCompressorOutletTemp",
          "dataType" : "DOUBLE",
          "description" : "Turbocharger temperature"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.TurbochargerBTempSupport",
          "dataType" : "DOUBLE",
          "description" : "Turbocharger temperature"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.TurbochargerBTurbineInletTemp",
          "dataType" : "DOUBLE",
          "description" : "Turbocharger temperature"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.TurbochargerBTurbineOutletTemp",
          "dataType" : "DOUBLE",
          "description" : "Turbocharger temperature"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.TurbochargerBrpm",
          "dataType" : "DOUBLE",
          "description" : "Turbocharger RPM"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.TurbochargerRpmSupport",
          "dataType" : "DOUBLE",
          "description" : "Turbocharger RPM"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.VGTSupport",
          "dataType" : "DOUBLE",
          "description" : "Variable Geometry turbo (VGT) control"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.VehicleFuelRate",
          "dataType" : "DOUBLE",
          "description" : "Engine Fuel Rate"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.VgtAPosition",
          "dataType" : "DOUBLE",
          "description" : "Variable Geometry turbo (VGT) control"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.VgtBPosition",
          "dataType" : "DOUBLE",
          "description" : "Variable Geometry turbo (VGT) control"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.WWHOBDSupported",
          "dataType" : "DOUBLE",
          "description" : "WWH-OBD Vehicle OBD Counters support"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.WarmupsSinceDTCClear",
          "dataType" : "DOUBLE",
          "description" : "PID 30 - Number of warm-ups since codes cleared"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.WastegateAPosition",
          "dataType" : "DOUBLE",
          "description" : "Wastegate control"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.WastegateBPosition",
          "dataType" : "DOUBLE",
          "description" : "Wastegate control"
        }
      },
      {
        "sensor" : {
          "fullyQualifiedName" : "Vehicle.OBD.WastegateControlSupport",
          "dataType" : "DOUBLE",
          "description" : "Wastegate control"
        }
      },
      {
        "actuator" : {
          "fullyQualifiedName" : "Vehicle.Powertrain.RideMode",
          "dataType" : "INT32",
          "description" : "Vehicle.Powertrain.RideMode"
        }
      },
      {
        "actuator" : {
          "fullyQualifiedName" : "Vehicle.Trunk.Open",
          "dataType" : "INT32",
          "description" : "Vehicle.Trunk.Open"
        }
      }
    ]
  }


}

