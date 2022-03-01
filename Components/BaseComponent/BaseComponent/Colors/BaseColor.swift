//
//  ColorComponent.swift
//  Components
//
//  Created by sky on 2/16/22.
//

import UIKit

public enum BaseColor {
    /// #5EE3D3
    public static let main = ColorProvider.color(named: "Main")
    
    public enum Indigo {
        /// #F2F4F7
        public static let indigo_5 = ColorProvider.color(named: "Indigo_5")
        /// #E7EAF3
        public static let indigo_10 = ColorProvider.color(named: "Indigo_10")
        /// #D6DBEB
        public static let indigo_20 = ColorProvider.color(named: "Indigo_20")
        /// #0D73EE
        public static let indigo_45 = ColorProvider.color(named: "Indigo_45")
        /// #005CCC
        public static let indigo_50 = ColorProvider.color(named: "Indigo_50")
    }
    
    public enum Denotive {
        /// #FFF3F1
        public static let red_5 = ColorProvider.color(named: "Red_5")
        /// #ED4540
        public static let red_45 = ColorProvider.color(named: "Red_45")
        /// #DE241D
        public static let red_50 = ColorProvider.color(named: "Red_50")
        /// #FFB429
        public static let orange_40 = ColorProvider.color(named: "Orange_40")
        /// #E58600
        public static let orange_50 = ColorProvider.color(named: "Orange_50")
        /// #F7FEF2
        public static let green_5 = ColorProvider.color(named: "Green_5")
        /// #4A9A1D
        public static let green_45 = ColorProvider.color(named: "Green_45")
        /// #408419
        public static let green_50 = ColorProvider.color(named: "Green_50")
    }
    
    public enum Grey {
        /// #FFFFFF
        public static let grey_0 = ColorProvider.color(named: "Grey_0")
        /// #F5F5F5
        public static let grey_5 = ColorProvider.color(named: "Grey_5")
        /// #E3E3E3
        public static let grey_10 = ColorProvider.color(named: "Grey_10")
        /// #C7C7C7
        public static let grey_20 = ColorProvider.color(named: "Grey_20")
        /// #8B8B8B
        public static let grey_40 = ColorProvider.color(named: "Grey_40")
        /// #757575
        public static let grey_50 = ColorProvider.color(named: "Grey_50")
        /// #5D5D5D
        public static let grey_60 = ColorProvider.color(named: "Grey_60")
        /// #2E2E2E
        public static let grey_80 = ColorProvider.color(named: "Grey_80")
        /// #000000
        public static let grey_100 = ColorProvider.color(named: "Grey_100")
    }
    
    public enum Tertiary {
        /// #FECDD0
        public static let tertiary_1_light = ColorProvider.color(named: "Tertiary 1 Light")
        /// #FC5C65
        public static let tertiary_1 = ColorProvider.color(named: "Tertiary 1")
        /// #FEE3CD
        public static let tertiary_2_light = ColorProvider.color(named: "Tertiary 2 Light")
        /// #FD9644
        public static let tertiary_2 = ColorProvider.color(named: "Tertiary 2")
        /// #FFF4CC
        public static let tertiary_3_light = ColorProvider.color(named: "Tertiary 3 Light")
        /// #FED330
        public static let tertiary_3 = ColorProvider.color(named: "Tertiary 3")
        /// #D3F8E5
        public static let tertiary_4_light = ColorProvider.color(named: "Tertiary 4 Light")
        /// #1EC370
        public static let tertiary_4 = ColorProvider.color(named: "Tertiary 4")
        /// #D5F6F3
        public static let tertiary_5_light = ColorProvider.color(named: "Tertiary 5 Light")
        /// #2BCBBA
        public static let tertiary_5 = ColorProvider.color(named: "Tertiary 5")
        /// #E1E5EA
        public static let tertiary_6_light = ColorProvider.color(named: "Tertiary 6 Light")
        /// #778CA3
        public static let tertiary_6 = ColorProvider.color(named: "Tertiary 6")
        /// #CFE9FC
        public static let tertiary_7_light = ColorProvider.color(named: "Tertiary 7 Light")
        /// #45AAF2
        public static let tertiary_7 = ColorProvider.color(named: "Tertiary 7")
        /// #E6D2F9
        public static let tertiary_8_light = ColorProvider.color(named: "Tertiary 8 Light")
        /// #A65EEA
        public static let tertiary_8 = ColorProvider.color(named: "Tertiary 8")
        /// #D1DDFA
        public static let tertiary_9_light = ColorProvider.color(named: "Tertiary 9 Light")
        /// #4B7BEC
        public static let tertiary_9 = ColorProvider.color(named: "Tertiary 9")
        /// #FECDDF
        public static let tertiary_10_light = ColorProvider.color(named: "Tertiary 10 Light")
        /// #FC5C96
        public static let tertiary_10 = ColorProvider.color(named: "Tertiary 10")
        /// #DEE5ED
        public static let tertiary_11_light = ColorProvider.color(named: "Tertiary 11 Light")
        /// #4B6584
        public static let tertiary_11 = ColorProvider.color(named: "Tertiary 11")
        /// #ECF8D3
        public static let tertiary_12_light = ColorProvider.color(named: "Tertiary 12 Light")
        /// #95CB23
        public static let tertiary_12 = ColorProvider.color(named: "Tertiary 12")
    }
    
    public enum Gradient {
        /// #005CCC
        public static let start = ColorProvider.color(named: "Start")
        /// #07E4E4
        public static let end = ColorProvider.color(named: "End")
    }
}

