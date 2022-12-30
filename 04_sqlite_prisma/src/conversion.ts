/**
 * This class is used to convert between units
 */
export class Conversion {
  /**
   * Convert distance to metres
   * @param distance
   * @returns
   */
  public static distanceToMetres(distance: string) {
    // regex to extract number with groups
    const regex = /(\d+.\d+|\d+) (\w+)/
    const match = distance.match(regex)
    if (match) {
      const d = parseFloat(match[1])
      const unit = match[2]
      if (unit === 'km') {
        return Math.ceil(d * 1000)
      }
      if (unit === 'm') {
        return d
      }
    }

    return 0
  }

  /**
   * Convert kilos to grams
   * @param weight
   * @returns
   */
  public static kilosToGrams(weight: string) {
    const regex = /(\d+.\d+|\d+) (\w+)/
    const match = weight.match(regex)
    if (match) {
      const w = parseFloat(match[1])
      const unit = match[2]
      if (unit === 'kg') {
        return Math.ceil(w * 1000)
      }
      if (unit === 'g') {
        return w
      }
    }

    return 0
  }
  /**
   * Convert metres to centimetres
   * @param metres
   * @returns
   * @example
   * expect(81).toBe(Conversion.metresToCm('0.81 m'))
   *
   */
  public static metresToCm(metres: string) {
    const regex = /(\d+.\d+|\d+) (\w+)/
    const match = metres.match(regex)
    if (match) {
      const m = parseFloat(match[1])
      const unit = match[2]
      if (unit === 'm') {
        return Math.ceil(m * 100)
      }
      if (unit === 'cm') {
        return m
      }
    }

    return 0
  }
}
