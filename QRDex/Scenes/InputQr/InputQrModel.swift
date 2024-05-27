import Foundation

enum InputTelQrError: Error {
    case FirstCharactorIsNotZero
    case Not10Digit
    case OrderingNumber
    case AllSingleNumber
    
    var title: String {
        switch self {
        case .FirstCharactorIsNotZero:
            return "เบอร์โทรศัพท์ต้องเริ่มต้นด้วย 0 เท่านั้น"
        case .Not10Digit:
            return "เบอร์โทรศัพท์ต้องมี 10 หลัก"
        case .OrderingNumber:
            return "เบอร์โทรศัพท์ห้ามเป็นเลขเรียงทั้งหมด"
        case .AllSingleNumber:
            return "เบอร์โทรศัพท์ห้ามเป็นเลขตัวเดียวทั้งหมด"
        }
    }
}

enum InputAmtQrError: Error {
    case FloatMore2Digit
    case IncorrectFormat
    
    var title: String {
        switch self {
        case .FloatMore2Digit:
            return "ห้ามใส่ทศนิยมเกินกว่าสองตำแหน่ง"
        case .IncorrectFormat:
            return "รูปแบบของทศนิยมผิดตำแหน่ง"
        }
    }
}
