--
-- Created by IntelliJ IDEA.
-- User: Stijn
-- Date: 17/01/2017
-- Time: 20:40
-- To change this template use File | Settings | File Templates.
--

local lang = SPACEBUILD.lang

lang.add("en", "tool.category.ls", "Life Support")
lang.add("en", "tool.category.rd", "Resource Distribution")
lang.add("en", "tool.category.sb", "Spacebuild")

lang.add("en", "tool.grav_plate.name", "Gravity Plating")
lang.add("en", "tool.grav_plate.desc", "Enables walking on a prop even in low-to-zero gravity." )
lang.add("en", "tool.grav_plate.0", "Left Click to attach Gravity Plating.  Right Click to take it off." )
lang.add("en", "tool.grav_plate.added", "Surface has received Gravity Plating.")
lang.add("en", "tool.grav_plate.removed", "Gravity Plating removed from surface.")

lang.add("en", "tool.rd3_dev_link.name", "Link Tool" )
lang.add("en", "tool.rd3_dev_link.desc", "Links Resource-Carrying Devices together to a Resource Node, including Vehicle Pods." )
lang.add("en", "tool.rd3_dev_link.0", "Left Click: Link Devices.  Right Click: Unlink Two Devices.  Reload: Unlink Device from All." )
lang.add("en", "tool.rd3_dev_link.1", "Click on another Resource-Carrying Device(or Vehicle Pod)" )
lang.add("en", "tool.rd3_dev_link.2", "Right-Click on another Resource-Carrying Device(or the same one to unlink ALL)" )
lang.add("en", "rd3_dev_link_addlength", "Add Length:" )
lang.add("en", "rd3_dev_link_width", "Width:" )
lang.add("en", "rd3_dev_link_material", "Material:" )
lang.add("en", "rd3_dev_link_colour", "Color:")

lang.add("en", "tool.rd3_dev_link2.name", "Smart Link Tool" )
lang.add("en", "tool.rd3_dev_link2.desc", "Links Resource-Carrying Devices to a Resource Node, including Vehicle Pods." )
lang.add("en", "tool.rd3_dev_link2.0", "Left Click: Select Devices.  Right Click: Link All devices to the selected Node.  Reload: Reset selected devices." )
lang.add("en", "tool.rd3_dev_link2.1", "Click on another Resource-Carrying Device(or Vehicle Pod)" )
lang.add("en", "rd3_dev_link2_addlength", "Add Length:" )
lang.add("en", "rd3_dev_link2_width", "Width:" )
lang.add("en", "rd3_dev_link2_material", "Material:" )
lang.add("en", "rd3_dev_link2_colour", "Color:")

lang.add("en", "tool.rd3_dev_link3.name", "Auto Link Tool" )
lang.add("en", "tool.rd3_dev_link3.desc", "Links Resource-Carrying Devices together to a Resource Node, including Vehicle Pods." )
lang.add("en", "tool.rd3_dev_link3.0", "Left Click: Auto link all devices in the range of the select node that aren't connected and are owned by you.  Right Click: Unlink Two Devices.  Reload: Unlink Device from All." )
lang.add("en", "tool.rd3_dev_link3.1", "Right Click on another Resource-Carrying Device (or the same one to unlink ALL)" )
lang.add("en", "rd3_dev_link3_addlength", "Add Length:" )
lang.add("en", "rd3_dev_link3_width", "Width:" )
lang.add("en", "rd3_dev_link3_material", "Material:" )
lang.add("en", "rd3_dev_link3_colour", "Color:")

lang.add("en", "tool.rd3_dev_link_adv.name", "Advanced Link Tool" )
lang.add("en", "tool.rd3_dev_link_adv.desc", "Links Resource-Carrying Devices together to a Resource Node, including Vehicle Pods. Waypoints can be set using this stool!!" )
lang.add("en", "tool.rd3_dev_link_adv.0", "Left Click: Link Devices.  Right Click: Place link point.  Reload: Unlink Device from All." )
lang.add("en", "tool.rd3_dev_link_adv.1", "Click on another Resource-Carrying Device(or Vehicle Pod)" )
lang.add("en", "tool.rd3_dev_link_adv.2", "Right-Click on another Resource-Carrying Device(or the same one to unlink ALL)" )
lang.add("en", "rd3_dev_link_adv_addlength", "Add Length:" )
lang.add("en", "rd3_dev_link_adv_width", "Width:" )
lang.add("en", "rd3_dev_link_adv_material", "Material:" )
lang.add("en", "rd3_dev_link_adv_colour", "Color:")

lang.add("en", "tool.rd3_dev_link_en_valve.name", "Entity Valve Link Tool" )
lang.add("en", "tool.rd3_dev_link_en_valve.desc", "Links an Entity or Resource Node to an Entity Valve." )
lang.add("en", "tool.rd3_dev_link_en_valve.0", "Left Click: Link Devices.  Right Click: Unlink Two Devices.  Reload: Unlink Device from All." )
lang.add("en", "tool.rd3_dev_link_en_valve.1", "Click on the next device (entity/Entity Valve/Resource node)" )
lang.add("en", "tool.rd3_dev_link_en_valve.2", "Right-Click on the next device (entity/Entity Valve/Resource node) to unlink the 2 devices" )
lang.add("en", "rd3_dev_link_en_valve_addlength", "Add Length:" )
lang.add("en", "rd3_dev_link_en_valve_width", "Width:" )
lang.add("en", "rd3_dev_link_en_valve_material", "Material:" )
lang.add("en", "rd3_dev_link_en_valve_colour", "Color:")

lang.add("en", "tool.rd3_dev_link_valve.name", "Valve Link Tool" )
lang.add("en", "tool.rd3_dev_link_valve.desc", "Links a resource node to a 1 or 2 way Valve." )
lang.add("en", "tool.rd3_dev_link_valve.0", "Left Click: Link Resource Node 1 to the valve.  Right Click: Link Resource Node2 to the Valve.  Reload: Unlink Device from All." )
lang.add("en", "tool.rd3_dev_link_valve.1", "Click on the next device (Valve/Resource node)" )
lang.add("en", "tool.rd3_dev_link_valve.2", "Right-Click on the next device (Valve/Resource node)" )
lang.add("en", "rd3_dev_link_valve_addlength", "Add Length:" )
lang.add("en", "rd3_dev_link_valve_width", "Width:" )
lang.add("en", "rd3_dev_link_valve_material", "Material:" )
lang.add("en", "rd3_dev_link_valve_colour", "Color:")

lang.add("en", "tool.rd3_resdebug.name",	"RD Resource Debuger" )
lang.add("en", "tool.rd3_resdebug.desc",	"Spams the ent's resource table to the console, Left Click = serverside, Right click = Clientside" )
lang.add("en", "tool.rd3_resdebug.0", "Click an RD3 Ent" )

