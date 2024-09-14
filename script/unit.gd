class_name Unit

const SIZE: int = 16

## Converts an amount of units to a pixels.
static func units_to_px(v: int) -> int:
  return v * SIZE


## Converts an amount of pixels to amount of units.
static func px_to_units(px: int) -> int:
  return snappedi(px, SIZE)
