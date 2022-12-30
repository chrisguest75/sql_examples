import { Conversion } from '../src/conversion'

describe('Height conversion', () => {
  it('should convert 0.81 m to 81 cm', () => {
    // ARRANGE
    const height = '0.81 m'
    // ACT
    const centimetres = Conversion.metresToCm(height)
    // ASSERT
    expect(81).toBe(centimetres)
  })

  it('should convert 1 m to 100 cm', () => {
    // ARRANGE
    const height = '1 m'
    // ACT
    const centimetres = Conversion.metresToCm(height)
    // ASSERT
    expect(100).toBe(centimetres)
  })

  it('should convert 1.67 m to 167 cm', () => {
    // ARRANGE
    const height = '1.67 m'
    // ACT
    const centimetres = Conversion.metresToCm(height)
    // ASSERT
    expect(167).toBe(centimetres)
  })

  it('should convert 0 m to 0cm', () => {
    // ARRANGE
    const height = '0 m'
    // ACT
    const centimetres = Conversion.metresToCm(height)
    // ASSERT
    expect(0).toBe(centimetres)
  })

  it('should return zero on an empty string', () => {
    // ARRANGE
    const height = ''
    // ACT
    const centimetres = Conversion.metresToCm(height)
    // ASSERT
    expect(0).toBe(centimetres)
  })

  /*it('should throw on a badly formatted string', () => {
    // ARRANGE
    const height = ' m'
    // ACT
    const centimetres = Conversion.metresToCm(height)
    // ASSERT
    expect(0).toBe(centimetres)
  })*/
})

describe('Weight conversion', () => {
  it('should convert 6.9 kg to 6900 grams', () => {
    // ARRANGE
    const weight = '6.9 kg'
    // ACT
    const grams = Conversion.kilosToGrams(weight)
    // ASSERT
    expect(6900).toBe(grams)
  })
})

describe('Distance conversion', () => {
  it('should convert 5 km to 5000 metres', () => {
    // ARRANGE
    const distance = '5 km'
    // ACT
    const metres = Conversion.distanceToMetres(distance)
    // ASSERT
    expect(5000).toBe(metres)
  })

  it('should convert 2.01 km to 2010 metres', () => {
    // ARRANGE
    const distance = '2.01 km'
    // ACT
    const metres = Conversion.distanceToMetres(distance)
    // ASSERT
    expect(2010).toBe(metres)
  })
})
