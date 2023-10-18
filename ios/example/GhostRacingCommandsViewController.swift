/*
 
Copyright 2021 Microoled
Licensed under the Apache License, Version 2.0 (the “License”);
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
    http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an “AS IS” BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
 
*/

import Foundation
import ActiveLookSDK

class GhostRacingCommandsViewController : CommandsTableViewController {
    
    var Bike: Bool = true
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Widget commands"
        
        commandNames = [
            "Bike or Running",
            "Approach",
            "First Data Screen",
            "Second Data Screen",
            "Segment details",
            "Segment start",
            "Live segment",
            "Segment completed",
            "Goals reached",
            "Ghost Racing user story",
            "Clear"
        ]
        
        commandActions = [
            self.grBikeOrRunning,
            self.grApproach,
            self.grFirstDataScreen,
            self.grSecondDataScreen,
            self.grSegmentDetails,
            self.grSegmentStart,
            self.grLiveSegment,
            self.grSegmentCompleted,
            self.grGoalsReached,
            self.grStoryTelling,
            self.clear
        ]
    }
    
    private let progressBarCoordinates = (
            x0: Int16(30 + 244),
            x1: Int16(30), // 30 = Horizontal margin
            y0: Int16(25 + 68), // 25 = Vertical margin
            y1: Int16(25 + 68 + 4)
    )
    
    // MARK: - Actions
    func grBikeOrRunning(){
        self.Bike = self.Bike ? false : true
    }

    func grReady(){
        glasses.clear()
        glasses.cfgSet(name: "ALooK")
        self.glasses.layoutDisplay(id: 6, text: "")
    }
    
    func grApproach(){
        glasses.clear()
        glasses.cfgSet(name: "ALooK")
        grApproachGlasses(isItBike: Bike)
    }
    
    func grFirstDataScreen(){
//                    BPM
//         _______________________
//        |_______________________|
//        elapsed time        distance
        glasses.clear()
        glasses.cfgSet(name: "ALooK")
        var val : Int = 0
        
        self.firstScreen(val: val)
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            val += 1
            self.firstScreen(val: val)
            
            if val == 5 {
                timer.invalidate()
            }
        }
    }
    
    func firstScreen(val: Int){
        let BPM : Int = 90
        let elapseTime : String = "00:0"
        let distance : String = "0.0"
        
        self.glasses.holdFlush(holdFlush: HoldFlushAction.HOLD)
        
        //Bpm
        self.glasses.layoutDisplayExtended(id: 83, x: 30, y: 129, text: "$\(BPM + val)")
        //Elapse time
        self.glasses.layoutDisplayExtended(id: 186, x: 257, y: 45, text: "0:")
        self.glasses.layoutDisplayExtended(id: 185, x: 168, y: 35, text: "\(elapseTime)\(val)")
        //Bike Cadence
        self.glasses.layoutDisplayExtended(id: 46, x: 30, y: 33, text: "\(distance)\(val)")
        
        self.glasses.color(level: 3)
        self.glasses.rectf(
            x0: self.progressBarCoordinates.x0,
            x1: self.progressBarCoordinates.x1,
            y0: self.progressBarCoordinates.y0,
            y1: self.progressBarCoordinates.y1
        )

        self.glasses.color(level: 15)
        self.glasses.rectf(
            x0: self.progressBarCoordinates.x0,
            x1: self.progressBarCoordinates.x0 - Int16((3 * val)),
            y0: self.progressBarCoordinates.y0,
            y1: self.progressBarCoordinates.y1
        )
        self.glasses.holdFlush(holdFlush: HoldFlushAction.FLUSH)
    }
    
    func grSecondDataScreen(){
//        elapsed time
//  _______________________
// |_______________________|
// speed       elevation gain
        
        glasses.clear()
        glasses.cfgSet(name: "ALooK")
        var val : Int = 0
        
        self.secondScreen(val: val)
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            val += 1
            self.secondScreen(val: val)
            
            if val == 5 {
                timer.invalidate()
            }
        }
    }
    
    func secondScreen(val: Int){
        let elapseTime = ["23:17", "23:18","23:19", "23:20","23:21","23:22"]
        let Speed = ["32", "32", "33", "32", "33", "33"]
        let elevationGain = ["1055", "1055", "1055", "1054", "1054", "1054"]
        
        self.glasses.holdFlush(holdFlush: HoldFlushAction.HOLD)
        
        //Elapse time
        self.glasses.layoutDisplayExtended(id: 80, x: 203, y: 154, text: "1:")
        self.glasses.layoutDisplayExtended(id: 79, x: 30, y: 129, text: "\(elapseTime[val])")
        //Speed
        self.glasses.layoutDisplayExtended(id: 44, x: 157, y: 33, text: "\(Speed[val])")
        //Elevation gain
        self.glasses.layoutDisplayExtended(id: 47, x: 30, y: 33, text: "\(elevationGain[val])")
        
        self.glasses.color(level: 3)
        self.glasses.rectf(
            x0: self.progressBarCoordinates.x0,
            x1: self.progressBarCoordinates.x1,
            y0: self.progressBarCoordinates.y0,
            y1: self.progressBarCoordinates.y1
        )

        self.glasses.color(level: 15)
        self.glasses.rectf(
            x0: self.progressBarCoordinates.x0,
            x1: self.progressBarCoordinates.x0 - Int16(178 + (5*val)),
            y0: self.progressBarCoordinates.y0,
            y1: self.progressBarCoordinates.y1
        )
        self.glasses.holdFlush(holdFlush: HoldFlushAction.FLUSH)
    }
    
    func grApproachGlasses(isItBike: Bool){
        self.glasses.holdFlush(holdFlush: HoldFlushAction.HOLD)
        if(isItBike){
            self.glasses.animDisplay(handlerId: 0, id: 15, delay: 100, repeatAnim: 0, x: 92, y:124)
        }else{
            self.glasses.animDisplay(handlerId: 0, id: 21, delay: 100, repeatAnim: 0, x: 92, y:124)
        }
        self.glasses.txt(x: 260, y: 125, rotation: TextRotation.topLR, font: 2, color: 15, string: "New segment")
        self.glasses.txt(x: 200, y: 85, rotation: TextRotation.topLR, font: 1, color: 6, string: "Get ready !")
        self.glasses.holdFlush(holdFlush: HoldFlushAction.FLUSH)
    }
    
    func grSegmentDetails(){
        glasses.clear()
        glasses.cfgSet(name: "ALooK")
        
        var val = 50
        val = grSegmentDetailsLoop(val: val, isItBike: Bike)
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            val = self.grSegmentDetailsLoop(val: val, isItBike: self.Bike)
            
            if val == 100 {
                timer.invalidate()
            }
        }
    }
    
    func grSegmentDetailsLoop(val: Int, isItBike: Bool)-> Int{
        self.glasses.holdFlush(holdFlush: HoldFlushAction.HOLD)
        
        if(isItBike){
            self.glasses.widgetTargetLeft(size: WidgetSize.large, x: 30, y: 60, value: UInt8(val*255/100), imgId: 89, valueType: WidgetValueType.number, unit: "m", shownValue:String(100-val), goal: "")
        }else{
            self.glasses.widgetTargetLeft(size: WidgetSize.large, x: 30, y: 60, value: UInt8(val*255/100), imgId: 94, valueType: WidgetValueType.number, unit: "m", shownValue:String(100-val), goal: "")
        }
        self.glasses.layoutDisplayExtended(id: 47, x: 157, y: 33, text: "1055")
        self.glasses.layoutDisplayExtended(id: 46, x: 30, y: 33, text: "347")
        
        self.glasses.txt(x: 274, y: 205, rotation: TextRotation.topLR, font: 1, color: 15, string: "")
        self.glasses.holdFlush(holdFlush: HoldFlushAction.FLUSH)
        return val+5
    }
    
    func grSegmentStart(){
        glasses.clear()
        glasses.cfgSet(name: "ALooK")
        grSegmentStartGlasses()
    }
    
    func grSegmentStartGlasses(){
        self.glasses.clear()
        self.glasses.holdFlush(holdFlush: HoldFlushAction.HOLD)
        self.glasses.animDisplay(handlerId: 0, id: 16, delay: 100, repeatAnim: 0, x: 66, y:47)
        self.glasses.holdFlush(holdFlush: HoldFlushAction.FLUSH)
    }
    
    func grLiveSegment(){
        glasses.clear()
        glasses.cfgSet(name: "ALooK")
        
        let gaugeDisplayValue = [
            //KOM
            "+0:00", "+0:01", "+0:01", "+0:02", "+0:02", "+0:03", "+0:04", "+0:05", "+0:06", "+0:08",
            //Wolf
            "-0:01", "-0:01", "-0:02", "-0:02", "-0:02", "-0:03",
            //PR
            "+0:02", "+0:02", "+0:01", "+0:01", "+0:00", "+0:00", "-0:00", "-0:00", "-0:01", "+0:00", "+0:00", "-0:00", "-0:01", "-0:02", "-0:03", "-0:03", "-0:04",
        ]
        let gaugeValue = [
            0, 22, 22, 44, 44, 64, 84, 104, 124, 160,
            235, 235, 215, 215, 215, 205,
            44, 44, 22, 22, 0, 0, 255, 255, 235, 0, 0, 255, 235, 215, 195, 214, 175,
        ]
        let gaugeImgId = [
            91, 91, 91, 91, 91, 91, 91, 91, 91, 91,
            95, 95, 95, 95, 95, 95,
            93 , 93 , 93 , 93 ,93 ,93 , 93 , 93 , 93 ,93 ,93 , 93 , 93 , 93 , 93 , 93 , 93 ,
        ]
        let gaugeZone = [
            2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
            1, 1, 1, 1, 1, 1,
            2 ,2 ,2 ,2 ,2 ,2 ,1 ,1 ,1 ,2 ,2 ,1 ,1 ,1 ,1 ,1 ,1,
        ]
        var distanceDisplayValue = 12.27
        var distanceProgressionValue = 0
        let bpmValue   = [
            160, 159, 158, 160, 162, 163, 160, 159, 158, 160,
            159, 159, 159, 159, 159, 159,
            160 ,158 , 157, 156, 158 ,160 ,161 , 162 ,161 ,160 ,160 ,161 ,159 ,161 ,162 ,161 ,159,
    ]
        
        var val = 0
        self.grLiveSegmentLoop(val: val, gaugeDisplayValue: gaugeDisplayValue[val], gaugeValue: gaugeValue[val], gaugeImgId: gaugeImgId[val], gaugeZone: gaugeZone[val], distanceDisplayValue: distanceDisplayValue,  distanceProgressionValue: distanceProgressionValue, bpmValue: bpmValue[val])
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            val+=1
            distanceDisplayValue-=0.37
            distanceProgressionValue+=8
            if(distanceProgressionValue > 255){
                distanceProgressionValue = 255
            }
            self.grLiveSegmentLoop(val: val, gaugeDisplayValue: gaugeDisplayValue[val], gaugeValue: gaugeValue[val], gaugeImgId: gaugeImgId[val], gaugeZone: gaugeZone[val], distanceDisplayValue: distanceDisplayValue,  distanceProgressionValue: distanceProgressionValue, bpmValue: bpmValue[val])
            
            if val == (gaugeDisplayValue.count - 1){
                //self.grLiveSegmentPositionLost(distanceDisplayValue: distanceDisplayValue,  distanceProgressionValue: distanceProgressionValue, bpmValue: bpmValue)
                timer.invalidate()
            }
        }
        
    }
    
    func grLiveSegmentLoop(val: Int, gaugeDisplayValue: String, gaugeValue: Int, gaugeImgId: Int, gaugeZone: Int, distanceDisplayValue: Double,  distanceProgressionValue: Int, bpmValue: Int){
        self.glasses.holdFlush(holdFlush: HoldFlushAction.HOLD)
        
        self.glasses.widgetGaugeZone(size: WidgetSize.large, x: 30, y: 83, value: UInt8(gaugeValue), imgId: UInt8(gaugeImgId), valueType: WidgetValueType.text, unit: "", shownValue: gaugeDisplayValue, chosenZone: UInt8(gaugeZone), zoneNb: 2)
        
        self.glasses.widgetTargetLeft(size: WidgetSize.half, x: 30, y: 25, value: UInt8(distanceProgressionValue), imgId: 9, valueType: WidgetValueType.number, unit: "m", shownValue:String(format: "%.1f", distanceDisplayValue), goal: "20")
        
        self.glasses.layoutDisplayExtended(id: 49, x: 140, y: 50, text: String(bpmValue))
        self.glasses.holdFlush(holdFlush: HoldFlushAction.FLUSH)
    }
    
    func grLiveSegmentPositionLost(distanceDisplayValue: Double,  distanceProgressionValue: Int, bpmValue: Int){
        self.glasses.holdFlush(holdFlush: HoldFlushAction.HOLD)
        
        self.glasses.widgetGaugeZone(size: WidgetSize.large, x: 30, y: 100, value: 255, imgId: 92, valueType: WidgetValueType.text, unit: "", shownValue: "--:--", chosenZone: 1, zoneNb: 2)
        
        self.glasses.widgetTargetLeft(size: WidgetSize.half, x: 30, y: 33, value: UInt8(distanceProgressionValue), imgId: 9, valueType: WidgetValueType.number, unit: "m", shownValue:String(format: "%.1f", distanceDisplayValue), goal: "20")
        
        self.glasses.layoutDisplayExtended(id: 49, x: 157, y: 33, text: String(bpmValue))
        self.glasses.holdFlush(holdFlush: HoldFlushAction.FLUSH)
    }
    
    func grSegmentCompleted(){
        glasses.clear()
        glasses.cfgSet(name: "ALooK")
        segmentCompleted()
    }
    
    func segmentCompleted(){
        glasses.holdFlush(holdFlush: HoldFlushAction.HOLD)
        glasses.animDisplay(handlerId: 0, id: 11, delay: 100, repeatAnim: 0, x: 115, y:120)
        
        glasses.txt(x: 250, y: 125, rotation: TextRotation.topLR, font: 3, color: 15, string: "1:33:54")
        
        glasses.txt(x: 252, y: 55, rotation: TextRotation.topLR, font: 1, color: 6, string: "Segment completed")
        
        glasses.holdFlush(holdFlush: HoldFlushAction.FLUSH)
    }
    
    func grGoalsReached(){
        glasses.clear()
        glasses.cfgSet(name: "ALooK")
        
        let val: Int = 1
        self.beatenGlasses(isItBike: Bike, val: val)
    }
    
    func beatenGlasses(isItBike: Bool, val: Int){
        let bikeAnimId = [17, 18, 19, 20]
        let RunAnimId  = [22, 23, 24, 25]
        self.glasses.holdFlush(holdFlush: HoldFlushAction.HOLD)
        
        if(isItBike){
            self.glasses.animDisplay(handlerId: 0, id: UInt8(bikeAnimId[val]), delay: 100, repeatAnim: 1, x: 81, y: 136)
        }else{
            self.glasses.animDisplay(handlerId: 0, id: UInt8(RunAnimId[val]), delay: 100, repeatAnim: 1, x: 81, y: 136)
        }
        switch val{
            // "Ahead of " + 8 char +"..."
        case 0: //wolf
            glasses.txt(x: 230, y: 125, rotation: TextRotation.topLR, font: 1, color: 15, string: "Ahead of Bradley ...")
        case 1: //pr
            glasses.txt(x: 210, y: 125, rotation: TextRotation.topLR, font: 2, color: 15, string: "New PR!")
        case 2: //carrot
            glasses.txt(x: 230, y: 125, rotation: TextRotation.topLR, font: 1, color: 15, string: "Ahead of Eric Mar...")
        case 3: //kom
            glasses.txt(x: 220, y: 125, rotation: TextRotation.topLR, font: 2, color: 15, string: "New KOM!")
        default:
            glasses.txt(x: 220, y: 125, rotation: TextRotation.topLR, font: 2, color: 15, string: "New KOM!")
        }
        glasses.txt(x: 200, y: 80, rotation: TextRotation.topLR, font: 2, color: 6, string: "-0:04")
        
        self.glasses.holdFlush(holdFlush: HoldFlushAction.FLUSH)
    }
    
    func grStoryTelling(){
        //Ready
        grReady()
        //Go
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
            self.grSegmentStartGlasses()
            //first data screen
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                self.grFirstDataScreen()
                //second data screen
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
                    self.grSecondDataScreen()
                    //Approach Anim
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
                        self.grApproach()
                        //Segment Detail
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
                            self.grSegmentDetails()
                            //Go
                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(10), execute: {
                                self.grSegmentStart()
                                //Live Segment
                                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                                    self.grLiveSegment()
                                    //New PR
                                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(32), execute: {
                                        self.grGoalsReached()
                                        //Segment Completed
                                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
                                            self.grSegmentCompleted()
                                        })
                                    })
                                })
                            })
                        })
                    })
                })
            })
        })
    }
    
    func drawMire(){
        glasses.rect(x0: 30, x1: 274, y0: 25, y1: 231)
        glasses.line(x0: 30, x1: 274, y0: 25, y1: 231)
        glasses.line(x0: 274, x1: 30, y0: 25, y1: 231)
        
        self.glasses.layoutDisplay(id: 10, text: "13:37")
        self.glasses.layoutDisplay(id: 7, text: "100%")
        self.glasses.layoutDisplay(id: 73, text: "")
    }
    
}
