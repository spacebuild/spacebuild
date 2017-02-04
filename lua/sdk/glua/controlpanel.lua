---
-- @description Library ControlPanel
 module("ControlPanel")

--- ControlPanel:AddControl
-- @usage client
-- This feature is deprecated.
--You should avoid using it as it may be removed in a future version.
--
--It is recommended to use DForm's members instead.
-- @param  type string  The control type to add. The complete list is:   header  textbox  label  checkbox/toggle  slider  propselect  matselect  ropematerial  button  numpad  color  combobox  listbox  materialgallery
-- @param  controlinfo table  Each control takes their own table structure. You may search "AddControl" on GitHub for examples. Here is a full list of each type and the table members it requires: header:     description textbox:     label (def: "Untitled")     command label:     text checkbox, toggle (same thing):     label (def: "Untitled")     command     help (boolean, if true assumes label is a language string ("#tool.toolname.stuff") and adds ".help" at the end) slider:     type (optional string, if equals "float" then 2 digits after the decimal will be used, otherwise 0)     label (def: "Untitled")     command     min (def: 0)     max (def: 100)     help (boolean, see above) propselect:     (data goes directly to PropSelect's :ControlValues(data)) matselect:     (data goes directly to MatSelect's :ControlValues(data)) ropematerial:     convar (notice: NOT called command this time!) button:     label / text (if label is missing will use text. Def: "No Label")     command numpad:     command     command2     label     label2 color:     label     red (convar)     green (convar)     blue (convar)     alpha (convar) combobox:     menubutton (if doesn't equal "1", becomes a listbox)     folder     options (optional, ha)     cvars (optional) listbox:     height (if set, becomes ListView, otherwise is ListBox)     label (def: "unknown")     options (optional) materialgallery:     width (def: 32)     height (def: 32)     rows (def: 4)     convar     options   
function AddControl( type,  controlinfo) end
