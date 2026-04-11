import QtQuick
import Quickshell
import Quickshell.Hyprland

PanelWindow {
    id: panel
    anchors {
        top: true
        left: true
        right: true
    }
    implicitHeight: 35
    margins.top: 0
    margins.left: 0
    margins.right: 0
    
    Rectangle {
        id: bar
        anchors.fill: parent
        color: "#00001f"
        radius: 0
        border.color: "#00001f"
        border.width: 3
        
        Row {
            id: workspacesRow
            anchors.centerIn: parent  // Center in parent instead of left
            spacing: 8
            
            Repeater {
                model: Hyprland.workspaces
                
                Rectangle {
                    width: 32
                    height: 24
                    radius: 25
                    color: modelData.active ? "#414a41" : "#000000"
                    border.color: "#111111"
                    border.width: 2
                    
                    MouseArea {
                        anchors.fill: parent
                        onClicked: Hyprland.dispatch("workspace " + modelData.id)
                    }
                    
                    Text {
                        text: toRoman(modelData.id)
                        anchors.centerIn: parent
                        color: modelData.active ? "#ffffff" : "#cccccc"
                        font.pixelSize: 12
                        font.family: "Iosevka Nerd Font"
                    }
                }
            }
        }
    }
    
    // Function to convert numbers to Roman numerals
    function toRoman(num) {
        const romanMap = [
            { value: 1000, numeral: "M" },
            { value: 900, numeral: "CM" },
            { value: 500, numeral: "D" },
            { value: 400, numeral: "CD" },
            { value: 100, numeral: "C" },
            { value: 90, numeral: "XC" },
            { value: 50, numeral: "L" },
            { value: 40, numeral: "XL" },
            { value: 10, numeral: "X" },
            { value: 9, numeral: "IX" },
            { value: 5, numeral: "V" },
            { value: 4, numeral: "IV" },
            { value: 1, numeral: "I" }
        ];
        
        let roman = "";
        let number = num;
        
        for (let i = 0; i < romanMap.length; i++) {
            while (number >= romanMap[i].value) {
                roman += romanMap[i].numeral;
                number -= romanMap[i].value;
            }
        }
        
        return roman;
    }
}
