# DekiPositioner

A library that contains convenience functions for positioning views.
                                                    

## How to use

```swift
/// Problem: You are given a design where a childView having size of 100 by 50, and having a leading offset of 200 and trailing offset of 100.
/// When the parentView shrink, the leading and trailing offset of childView should have same ratio with the original offsets, which is 2:1
///
/// Parent view: 400 width by 200 height
/// -------------------------------------------------------------------------
/// |                                                                                                                                                                 |
/// |                                                                                                                                                                 |
/// |                                                                              ____________________                                          |
/// |                                                                              |                                       |                                          |
/// |                                <--- 200 --->                 |                                       |  <--- 100 --->           |
/// |                                                                              |                                       |                                          |
/// |                                                                              |                                       |                                          |
/// |                                                                              ----------------------------------                                          |
/// |                                                                                                                                                                 |
/// |                                                                                                                                                                 |
/// -------------------------------------------------------------------------
///
/// Solution: Using SnapKit, use the `offsetCenterX(_:relativeViewBaseWidth:)` to proportionally offset the center on the parent view regardless of the change of size of the parent view.

let parentView = UIView()
let childView = UIView()

parentView.addSubview(childView)

parentView.snp.makeConstraints { make in
    make.size.equalTo(CGSize(width: 400, height: 200))
    make.center.equalToSuperview()
}

childView.snp.makeConstraints { make in
    make.size.equalTo(CGSize(width: 100, height: 50))
    make.centerY.equalToSuperview()
    let baseXDimensions = BaseXDimensions(leadingOffset: 200, trailingOffset: 100)
    make.centerX.equalToSuperview().offsetCenterX(baseXDimensions, relativeViewBaseWidth: 400)
}

```
