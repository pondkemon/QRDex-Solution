import Foundation

enum InputQrError: Error {
    case FirstCharactorIsNotZero
    case Not10Digit
    case OrderingNumber
    case AllSingleNumber
}
