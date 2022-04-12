// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1

PageStackWindow {
    id: purchasePageStackWindow
    showStatusBar: false
    initialPage: purchasePage

    Page {
        id: purchasePage
        orientationLock: PageOrientation.LockLandscape

        Rectangle{
            id: background
            anchors.fill: parent
            anchors.margins: 2
            border.color: "white"
            radius: 6
            color: "black"
        }

        function currentDate(){
            return new Date();
        }

        function defaultText(){
            if(DaysLeft>0)
                return "IDEAL APPS<br/>This is a 2 days trial version of Saita @ School.<br/>" + DaysLeft + " day left to end the trial version period.<br/>Tap on the button TRIAL in order to continue to use the trial version or tap the button GET THE GAME in order to get the game."
            else
                return "IDEAL APPS<br/>Thank you for playing Saita.<br/> The trial version has ended.<br/><br/>Please tap the button GET THE GAME in order to get the game or tap Exit to exit the game."
        }

        BusyIndicator{ id:busyIndicator; visible: running; anchors.centerIn: parent; width: 64; height: 64; z: 200; running: false }


        Item{
            id: container

            anchors.verticalCenter: parent.verticalCenter
            width: parent.width- 12
            height: column.height
            anchors.left: parent.left
            anchors.leftMargin: 6
            anchors.rightMargin: 6

            Column{
                id: column
                width: parent.width
                //anchors.centerIn: parent.horizontalCenter
                spacing: 10

                // Given text, centered within the dialog.
                Text {
                    id: dlgText
                    width: parent.width
                    text: purchasePage.defaultText();
                    color: "white"
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                }

                // Under the text field there's two clickable buttons.
                Row {
                    spacing: 10
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                    }

                    Button {
                        id: okButton
                        text: "TRIAL"
                        width: 150
                        onClicked: { PurchaseUtility.useTrial() }
                        visible: DaysLeft>=0? true: false
                    }

                    Button {
                        id: cancelButton
                        text: qsTr("GET THE GAME")
                        width: 150
                        platformInverted: true

                        // On click emit "cancelled" signal via the main level dialog Item
                        // and hide the dialog.
                        onClicked: { purchaseDialog.show() }
                    }
                } // Row

                Row{
                    spacing: 10
                    anchors.horizontalCenter: parent.horizontalCenter

                    Button{
                        text: qsTr("Restore")
                        width: 150
                        anchors.verticalCenter: parent.verticalCenter
                        onClicked: restoreDialog.show()
                    }

                    Button{
                        text: qsTr("Exit")
                        width: 150
                        anchors.verticalCenter: parent.verticalCenter
                        onClicked: Qt.quit()
                    }
                }


            }
        }

        Connections{
            target: PurchaseUtility

            onDataReceived: {
                var text = "IDEAL APPS<br/>"
                text += info + "      " + price + "<br/>"
                text += shortdescription + "<br/>"
                text += description + "<br/>Tap Ok to get the app or Cancel to go back."

                purchaseDialog.text = text;
            }
        }

        // Visual is an item that defines some constants for the application
        // look and feel, e.g. the font sizes & colors etc.
        Visual {
            id: visual
        }

        ModalDialog {
            id: purchaseDialog
            opacity: 1

            // Shown text can be set by modifying "text" property.
            text: qsTr("IDEAL APPS<br/>Saita @ School Premium Version<br/>You are trying to purchase the FULL premium version of Saita @ School.<br/>Tap Ok to get premium version or Cancel to go back.")

            // Always remember to define the size for the dialog.
            anchors.fill: parent

            z: 20

            // Demonstrating how one could keep application wide variables saved
            // in one place and use them conveniently all around the application.
            fontName: visual.defaultFontFamily
            fontColor: visual.defaultFontColor
            fontColorButton: visual.defaultFontColorButton
            fontSize: visual.defaultFontSize

            onAccepted: {
                // When dialog is accepted, e.g. the data model could be updated.
                // Just debug print here to show how to use the ModalDialog signals.
                PurchaseUtility.buyProduct();

            }
            onCancelled: {

            }
        }

        ModalDialog {
            id: restoreDialog
            opacity: 1

            // Shown text can be set by modifying "text" property.
            text: qsTr("IDEAL APPS<br/><br/>Tap Ok to restore the premium version of the game or Cancel to go back.")

            // Always remember to define the size for the dialog.
            anchors.fill: parent

            z: 20

            // Demonstrating how one could keep application wide variables saved
            // in one place and use them conveniently all around the application.
            fontName: visual.defaultFontFamily
            fontColor: visual.defaultFontColor
            fontColorButton: visual.defaultFontColorButton
            fontSize: visual.defaultFontSize

            onAccepted: {
                // When dialog is accepted, e.g. the data model could be updated.
                // Just debug print here to show how to use the ModalDialog signals.
                busyIndicator.running = true;

                PurchaseUtility.restoreProducts();

            }
            onCancelled: {

            }
        }

        Connections{
            target: PurchaseUtility

            onPurchaseSucceeded: purchaseSuccessDialog.show()
            onRestoreCompleted: { busyIndicator.running = false; purchaseDialog.show() }
        }

        ModalDialog {
            id: purchaseSuccessDialog
            opacity: 1

            // Shown text can be set by modifying "text" property.
            text: qsTr("IDEAL APPS<br/>Thank you for buying the premium version of Saita @ School.<br/><br/>Please tap the button Ok and restart the game.")

            // Always remember to define the size for the dialog.
            anchors.fill: parent

            showCancelButton: false

            z: 20

            // Demonstrating how one could keep application wide variables saved
            // in one place and use them conveniently all around the application.
            fontName: visual.defaultFontFamily
            fontColor: visual.defaultFontColor
            fontColorButton: visual.defaultFontColorButton
            fontSize: visual.defaultFontSize

            onAccepted: {
                // When dialog is accepted, e.g. the data model could be updated.
                // Just debug print here to show how to use the ModalDialog signals.
                Qt.quit();

            }
        }
    }
}
