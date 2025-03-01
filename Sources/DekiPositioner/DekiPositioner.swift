// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import SnapKit

public extension ConstraintMakerEditable {
    /// Keeps the center X offset consistent and proportional to its relative view (normally its container)
    /// If you are referring to a design (e,g, figma) and you have a view that is not totally centered, it would not be ideal to put constant center offset since it will break when the relative view or container changes size
    /// In this case, you need a center factor that will always make the center position consistent
    ///
    /// `BaseXDimensions`
    /// - `leadingOffset` - the distance between the leading of the view and the leading of the relative view (or container)
    /// - `trailingOffset` - the distance between the trailing of the view and the trailing of the relative view (or container)
    /// `relativeViewBaseWidth` - the width of the relative view
    ///
    /// These dimensions are in base values and are needed  to calculate the factor to be applied on the center constraint.
    @discardableResult
    func offsetCenterX(_ baseXDim: BaseXDimensions, relativeViewBaseWidth: CGFloat) -> ConstraintMakerEditable {
        let centerFactor = calculateCenterPositionXFactor(baseXDim: baseXDim, relativeViewBaseDimWidth: relativeViewBaseWidth)
        return multipliedBy(centerFactor)
    }
    
    /// Keeps the center Y offset consistent and proportional to its relative view (normally its container)
    /// If you are referring to a design (e,g, figma) and you have a view that is not totally centered, it would not be ideal to put constant center offset since it will break when the relative view or container changes size
    /// In this case, you need a center factor that will always make the center position consistent
    ///
    /// `BaseYDimensions`
    /// - `topOffset` - the distance between the top of the view and the top of the relative view (or container)
    /// - `bottomOffset` - the distance between the bottom of the view and the bottom of the relative view (or container)
    /// `relativeViewBaseWidth` - the width of the relative view
    ///
    /// These dimensions are in base values and are needed  to calculate the factor to be applied on the center constraint.
    @discardableResult
    func offsetCenterY(_ baseYDim: BaseYDimensions, relativeViewBaseHeight: CGFloat) -> ConstraintMakerEditable {
        let centerFactor = calculateCenterPositionYFactor(baseYDim: baseYDim, relativeViewBaseDimHeight: relativeViewBaseHeight)
        return multipliedBy(centerFactor)
    }
}




func calculateCenterPositionXFactor(
    baseXDim: BaseXDimensions,
    relativeViewBaseDimWidth: CGFloat
) -> CGFloat {
    calculateCenterPositionXorY(
        baseTopOrLeadingOffset: baseXDim.leadingOffset,
        baseBottomOrTrailingOffset: baseXDim.trailingOffset,
        baseRelativeViewDim: relativeViewBaseDimWidth
    )
}

/// Calculates the center position Y factor of a view
func calculateCenterPositionYFactor(
    baseYDim: BaseYDimensions,
    relativeViewBaseDimHeight: CGFloat
) -> CGFloat {
    calculateCenterPositionXorY(
        baseTopOrLeadingOffset: baseYDim.topOffset,
        baseBottomOrTrailingOffset: baseYDim.bottomOffset,
        baseRelativeViewDim: relativeViewBaseDimHeight
    )
}

private func calculateCenterPositionXorY(
    baseTopOrLeadingOffset: CGFloat,
    baseBottomOrTrailingOffset: CGFloat,
    baseRelativeViewDim: CGFloat
) -> CGFloat {
    let averageOffset = (baseTopOrLeadingOffset + baseBottomOrTrailingOffset) / 2
    let diff = averageOffset - baseTopOrLeadingOffset
    let baseDimHalf = baseRelativeViewDim / 2
    let percentDiff = diff / baseDimHalf
    
    let centerMultiplyingFactor = 1 - percentDiff
    return centerMultiplyingFactor
}

public struct BaseYDimensions {
    let topOffset: CGFloat
    let bottomOffset: CGFloat
}

public struct BaseXDimensions {
    let leadingOffset: CGFloat
    let trailingOffset: CGFloat
}
