//
//  PrayerTime.swift
//  IslomUz
//
//  Created by olmosbek on 7/15/20.
//  Copyright © 2020 olmosbek. All rights reserved.
//


//import UIKit
//import Darwin
//import CoreLocation
import Foundation
import CoreLocation
//import TimeZoneLocate

class PrayerTime {
    
    //MARK:- Prayer time count
    
    static let shared = PrayerTime()
    
    func getCurrentTimeZone(latitude: Double,
                            longitude: Double) -> Double {
        
        //        let location = CLLocation(latitude: latitude, longitude: longitude)
        let timeZone = TimeZone.current.secondsFromGMT()
        
        return Double(timeZone / 3600)
    }
    
    func calculateSalahTimes(
        year: Int,
        month: Int,
        day: Int,
        timeZoneDiffInHour: Double,
        latitude: Double,
        longitude: Double,
        altitude: Double,
        fajrAngle: Double,
        asrShadowRatio: Double,
        ishaAngle: Double)-> [Double] {
            
            let timeZone = getCurrentTimeZone(latitude: latitude, longitude: longitude)
            
            let jd = gregorian2Julian(year, month, day)
            
            //            let yesterday = calculateSalahTimes(jd - 1, timeZone, latitude, longitude, altitude, fajrAngle, asrShadowRatio, ishaAngle)
            let today = calculateSalahTimes(jd, timeZone, latitude, longitude, altitude, fajrAngle, asrShadowRatio, ishaAngle)
            //            let tomorrow = calculateSalahTimes(jd + 1, timeZone, latitude, longitude, altitude, fajrAngle, asrShadowRatio, ishaAngle)
            
            return [
                //                yesterday[5] + (Double(UserDefaults.standard.integer(forKey: "Extend5")) / 60),
                (today[0] - 0.0833 + (Double(UserDefaults.standard.integer(forKey: "Extend0")) / 60)),
                today[1] + (Double(UserDefaults.standard.integer(forKey: "Extend1")) / 60),
                today[2] + (Double(UserDefaults.standard.integer(forKey: "Extend2")) / 60),
                today[3] + (Double(UserDefaults.standard.integer(forKey: "Extend3")) / 60),
                today[4] + 0.0833 + (Double(UserDefaults.standard.integer(forKey: "Extend4")) / 60),
                today[5] + (Double(UserDefaults.standard.integer(forKey: "Extend5")) / 60),
                //                tomorrow[0] + (Double(UserDefaults.standard.integer(forKey: "Extend0")) / 60)]
            ]
        }
    //2459869.5
    func calcualtePrayingTimes(julianDate: Double,asrShadowRatio: Double, fajrAngle: Double, ishaAngle: Double, ishaOffset: Double) -> [Double] {
        
        let highLatitudeMethod = HighLatitudeMethod.ANGULAR
        let lat = UserDefaults.standard.double(forKey: "Latitude") //41.31 // UserDefaults.standard.double(forKey: "Latitude")
        let long = UserDefaults.standard.double(forKey: "Longitude") // UserDefaults.standard.double(forKey: "Longitude")
        let hours: Double = getCurrentTimeZone(latitude: lat, longitude: long)
        
        let asrAngle =  2.0
        
        var isIshaMethod = true //UserDefaults.standard.getIshaMinutes()
        
        switch UserDefaults.standard.string(forKey: "idoraUslubi") {
        case "Уммул Қуръо (Макка)", "Ummul Qur'o (Makka)", "Umm Al-Qura, Makkah", "Умм Аль-Кура, Мекка":
            isIshaMethod = true
        default:
            break
        }
        
        
        return calculatePrayingTime(
            julianDate: julianDate,
            timeZoneHoursOffset: hours,
            latitude: lat,
            longitude: long,
            altitude: 0,
            asrShadowRatio: asrAngle,
            fajrAngle: fajrAngle,
            ishaAngle: ishaAngle,
            isFixedIshaMethod: isIshaMethod,
            ishaOffset: ishaOffset,
            highLatitudeMethod: highLatitudeMethod)
    }
    
    func getPrayingTimes() -> [Double] {
        let juilianDate = CalculateJuliaDate.shared.getJulianDate(
            year: Calendar.current.component(.year, from: Date()),
            month: Calendar.current.component(.month, from: Date()),
            day: Calendar.current.component(.day, from: Date())
        )
        let fajrAngle: Double = 15 //UserDefaults.standard.getFajrAngle()
        let ishaAngle: Double = 15 //UserDefaults.standard.getIshaAngle()
        
        return calcualtePrayingTimes4Widget(
            julianDate: juilianDate,
            asrShadowRatio: 2,
            fajrAngle: fajrAngle,
            ishaAngle: ishaAngle,
            ishaOffset: ishaAngle,
            isFixedIshaMethod: true
        )
    }
    
    func calcualtePrayingTimes4Widget(
        julianDate: Double,
        asrShadowRatio: Double,
        fajrAngle: Double,
        ishaAngle: Double,
        ishaOffset: Double,
        isFixedIshaMethod: Bool) -> [Double] {
            
            let highLatitudeMethod = HighLatitudeMethod.ANGULAR
            let lat = 41.1
            let long = 69.0
            let hours: Double = getCurrentTimeZone(latitude: lat, longitude: long)
            
            let asrAngle =  2.0
            
            return calculatePrayingTime(
                julianDate: julianDate,
                timeZoneHoursOffset: hours,
                latitude: lat,
                longitude: long,
                altitude: 0,
                asrShadowRatio: asrAngle,
                fajrAngle: fajrAngle,
                ishaAngle: ishaAngle,
                isFixedIshaMethod: isFixedIshaMethod,
                ishaOffset: ishaOffset,
                highLatitudeMethod: highLatitudeMethod)
        }
    
    func calcualtePrayingTimesForWatch(
        latitude: Double,
        longtitude: Double,
        julianDate: Double,
        asrShadowRatio: Double,
        fajrAngle: Double,
        ishaAngle: Double,
        ishaOffset: Double,
        mazhab: Double,
        isFixedIshaMethod: Bool) -> [Double] {
            
            let highLatitudeMethod = HighLatitudeMethod.ANGULAR
            let hours: Double = getCurrentTimeZone(latitude: latitude, longitude: longtitude)
            
            return calculatePrayingTime(
                julianDate: julianDate,
                timeZoneHoursOffset: hours,
                latitude: latitude,
                longitude: longtitude,
                altitude: 0,
                asrShadowRatio: mazhab,
                fajrAngle: fajrAngle,
                ishaAngle: ishaAngle,
                isFixedIshaMethod: isFixedIshaMethod,
                ishaOffset: ishaOffset,
                highLatitudeMethod: highLatitudeMethod)
        }
    
    private func calculatePrayingTime(julianDate: Double,
                                      timeZoneHoursOffset: Double,
                                      latitude: Double,
                                      longitude: Double,
                                      altitude: Double,
                                      asrShadowRatio: Double,
                                      fajrAngle: Double,
                                      ishaAngle: Double,
                                      isFixedIshaMethod: Bool,
                                      ishaOffset: Double,
                                      highLatitudeMethod: HighLatitudeMethod) -> [Double] {
        let todaySunPosition =
        calculateSunPositions(julianDate, timeZoneHoursOffset, latitude, longitude, altitude)
        let tomorrowSunPosition =
        calculateSunPositions(julianDate + 1, timeZoneHoursOffset, latitude, longitude, altitude)
        let yesterdaySunPosition =
        calculateSunPositions(julianDate - 1, timeZoneHoursOffset, latitude, longitude, altitude)
        
        var yesterdayIsha: Double = 0.0
        
        if isFixedIshaMethod {
            yesterdayIsha = fixHour(yesterdaySunPosition.sunset + ishaAngle / 60)
        } else {
            let it = fixHour(
                yesterdaySunPosition.midday + toDegrees(
                    acos(
                        (-sin(toRadians(ishaAngle)) - sin(
                            toRadians(
                                latitude
                            )
                        ) * sin(toRadians(yesterdaySunPosition.sunAngle))) / (cos(toRadians(latitude)) * cos(
                            toRadians(
                                yesterdaySunPosition.sunAngle
                            )
                        ))
                    )
                ) / 15)
            yesterdayIsha = adjustIsha(time: it, sunset: yesterdaySunPosition.sunset, sunrise: todaySunPosition.sunrise, angle: ishaAngle, highLatitudeMethod: highLatitudeMethod)
        }
        
        let tempFajr = fixHour(
            todaySunPosition.midday - toDegrees(
                acos(
                    (-sin(toRadians(fajrAngle)) - sin(
                        toRadians(
                            latitude
                        )
                    ) * sin(toRadians(todaySunPosition.sunAngle))) / (cos(toRadians(latitude)) * cos(
                        toRadians(
                            todaySunPosition.sunAngle
                        )
                    ))
                )
            ) / 15)
        let fajr = adjustFajr(time: tempFajr, sunset: yesterdaySunPosition.sunset, sunrise: todaySunPosition.sunrise, angle: fajrAngle, highLatitudeMethod: highLatitudeMethod)
        
        let asr = fixHour(
            todaySunPosition.midday + fixHour(
                toDegrees(
                    acos(
                        (sin(atan(1 / (asrShadowRatio + tan(toRadians(latitude - todaySunPosition.sunAngle))))) - sin(
                            toRadians(
                                latitude
                            )
                        ) * sin(toRadians(todaySunPosition.sunAngle))) / (cos(toRadians(latitude)) * cos(
                            toRadians(
                                todaySunPosition.sunAngle
                            )
                        ))
                    )
                ) / 15
            )
        )
        var isha: Double = 0
        if isFixedIshaMethod {
            isha = fixHour(todaySunPosition.sunset + ishaAngle / 60)
        } else {
            let fixHour = fixHour(
                todaySunPosition.midday + toDegrees(
                    acos(
                        (-sin(toRadians(ishaAngle)) - sin(
                            toRadians(
                                latitude
                            )
                        ) * sin(toRadians(todaySunPosition.sunAngle))) / (cos(toRadians(latitude)) * cos(
                            toRadians(
                                todaySunPosition.sunAngle
                            )
                        ))
                    )
                ) / 15
            )
            isha = adjustIsha(time: fixHour, sunset: todaySunPosition.sunset, sunrise: tomorrowSunPosition.sunrise, angle: ishaAngle, highLatitudeMethod: highLatitudeMethod)
        }
        
        var tomorrowFajr: Double = 0.0
        
        let fixHour = fixHour(
            tomorrowSunPosition.midday - toDegrees(
                acos(
                    (-sin(toRadians(fajrAngle)) - sin(
                        toRadians(
                            latitude
                        )
                    ) * sin(toRadians(tomorrowSunPosition.sunAngle))) / (cos(toRadians(latitude)) * cos(
                        toRadians(
                            tomorrowSunPosition.sunAngle
                        )
                    ))
                )
            ) / 15
        )
        
        tomorrowFajr = adjustFajr(time: fixHour, sunset: todaySunPosition.sunset, sunrise: tomorrowSunPosition.sunrise, angle: fajrAngle, highLatitudeMethod: highLatitudeMethod)
        
        //        yesterday[5] + (Double(UserDefaults.standard.integer(forKey: "Extend5")) / 60),
        //        (today[0] - 0.0833 + (Double(UserDefaults.standard.integer(forKey: "Extend0")) / 60)),
        //        today[1] + (Double(UserDefaults.standard.integer(forKey: "Extend1")) / 60),
        //        today[2] + (Double(UserDefaults.standard.integer(forKey: "Extend2")) / 60),
        //        today[3] + (Double(UserDefaults.standard.integer(forKey: "Extend3")) / 60),
        //        today[4] + 0.0833 + (Double(UserDefaults.standard.integer(forKey: "Extend4")) / 60),
        //        today[5] + (Double(UserDefaults.standard.integer(forKey: "Extend5")) / 60),
        //        tomorrow[0] + (Double(UserDefaults.standard.integer(forKey: "Extend0")) / 60)]
        
        let forceFajrMaghrebOffset = 5.0 / 60
        //        let ishaAdjustment = (Double(UserDefaults.standard.integer(forKey: "Extend5")) / 60)
        //        let fajrAdjustment = -forceFajrMaghrebOffset + Double(UserDefaults.standard.integer(forKey: "Extend0")) / 60
        //        let sunriseAdjustment = (Double(UserDefaults.standard.integer(forKey: "Extend1")) / 60)
        //        let dhuhrAdjustment = (Double(UserDefaults.standard.integer(forKey: "Extend2")) / 60)
        //        let asrAdjustment = (Double(UserDefaults.standard.integer(forKey: "Extend3")) / 60)
        //        let maghrebAdjustment = forceFajrMaghrebOffset + (Double(UserDefaults.standard.integer(forKey: "Extend4")) / 60)
        
        
        
        return [
            yesterdayIsha,
            fajr - forceFajrMaghrebOffset,
            todaySunPosition.sunrise,
            todaySunPosition.midday,
            asr,
            todaySunPosition.sunset + forceFajrMaghrebOffset,
            isha,
            tomorrowFajr
        ]
    }
    
    private func adjustIsha(time: Double,
                            sunset: Double,
                            sunrise: Double,
                            angle: Double,
                            highLatitudeMethod: HighLatitudeMethod) -> Double {
        let nightDuration = fixHour(sunrise - sunset)
        let timeDiff = fixHour(time - sunset)
        let nightPortion = nightPortion(nightDuration: nightDuration, angle: angle, highLatitudeMethod: highLatitudeMethod)
        if (time.isNaN || timeDiff > nightPortion) {
            return fixHour(sunset + nightPortion)
        } else {
            return time
        }
    }
    
    private func adjustFajr(time: Double,
                            sunset: Double,
                            sunrise: Double,
                            angle: Double,
                            highLatitudeMethod: HighLatitudeMethod) -> Double {
        let nightDuration = fixHour(sunrise - sunset)
        let timeDiff = fixHour(sunrise - time)
        let nightPortion = nightPortion(nightDuration: nightDuration, angle: angle, highLatitudeMethod: highLatitudeMethod)
        if (time.isNaN) || (timeDiff > nightPortion) {
            return fixHour(sunrise - nightPortion)
        } else {
            return time
        }
    }
    
    private func nightPortion(nightDuration: Double,
                              angle: Double,
                              highLatitudeMethod: HighLatitudeMethod) -> Double {
        switch highLatitudeMethod {
        case .ANGULAR:
            return nightDuration * (angle / 60.0)
        case .MIDNIGHT:
            return nightDuration * 0.5
        case .ONE_SEVENTH:
            return nightDuration * (1.0 / 7.0)
        }
    }
    
    private func calculateSunPositions(_ julianDate: Double,
                                       _ timeZoneDiffInHour: Double,
                                       _ latitude: Double,
                                       _ longitude: Double,
                                       _ altitude: Double) -> SunPosition {
        
        let january2000 = julianDate - 2451545.0
        let g = fixAngle(357.529 + 0.98560028 * january2000)
        let q = fixAngle(280.459 + 0.98564736 * january2000)
        let l = fixAngle(q + 1.915 * sin(toRadians(g)) + 0.020 * sin(toRadians(2 * g)))
        let e = fixHour(23.439 - 0.00000036 * january2000)
        let ra =
        fixHour(
            toDegrees(
                atan2(
                    cos(toRadians(e)) * sin(toRadians(l)),
                    cos(toRadians(l))
                )
            ) / 15
        )
        let sunAngle = toDegrees(asin(sin(toRadians(e)) * sin(toRadians(l))))
        let eqt = q / 15 - ra
        let o = 0.833 + 0.0347 * sqrt(altitude)
        let midday = fixHour(12 + timeZoneDiffInHour - longitude / 15 - eqt)
        let sunrise = fixHour(
            midday - toDegrees(
                acos(
                    (-sin(toRadians(o)) - sin(toRadians(latitude)) * sin(toRadians(sunAngle))) / (cos(
                        toRadians(
                            latitude
                        )
                    ) * cos(toRadians(sunAngle)))
                )
            ) / 15
        )
        let sunset = fixHour(
            midday + toDegrees(
                acos(
                    (-sin(toRadians(o)) - sin(toRadians(latitude)) * sin(toRadians(sunAngle))) / (cos(
                        toRadians(
                            latitude
                        )
                    ) * cos(toRadians(sunAngle)))
                )
            ) / 15
        )
        
        return SunPosition(sunrise: sunrise, midday: midday, sunset: sunset, sunAngle: sunAngle)
        
    }
    
    private func calculateSalahTimes(_ julianDate: Double,
                                     _ timeZoneDiffInHour: Double,
                                     _ latitude: Double,
                                     _ longitude: Double,
                                     _ altitude: Double,
                                     _ fajrAngle: Double,
                                     _ asrShadowRatio: Double,
                                     _ ishaAngle: Double) -> [Double] {
        
        let timeZone = getCurrentTimeZone(latitude: latitude, longitude: longitude)
        
        
        let january2000 = julianDate - 2451545.0
        let g = fixAngle(357.529 + 0.98560028 * january2000)
        let q = fixAngle(280.459 + 0.98564736 * january2000)
        let l = fixAngle(q + 1.915 * sin(toRadians(g)) + 0.020 * sin(toRadians(2 * g)))
        let e = fixHour(23.439 - 0.00000036 * january2000)
        let ra = fixHour(toDegrees(atan2(cos(toRadians(e)) * sin(toRadians(l)), cos(toRadians(l)))) / 15)
        let d = toDegrees(asin(sin(toRadians(e)) * sin(toRadians(l))))
        let eqt = q / 15 - ra
        
        
        let midday = fixHour(12 + timeZone - longitude / 15 - eqt)
        let fajr = fixHour(midday - toDegrees(acos((-sin(toRadians(fajrAngle)) - sin(toRadians(latitude)) * sin(toRadians(d))) / (cos(toRadians(latitude)) * cos(toRadians(d))))) / 15)
        let sunrise = fixHour(midday - toDegrees(acos((-sin(toRadians(0.833)) - sin(toRadians(latitude)) * sin(toRadians(d))) / (cos(toRadians(latitude)) * cos(toRadians(d))))) / 15)
        let asr = fixHour(midday + toDegrees(acos((sin(atan(1 / (asrShadowRatio + tan(toRadians(latitude - d))))) - sin(toRadians(latitude)) * sin(toRadians(d))) / (cos(toRadians(latitude)) * cos(toRadians(d))))) / 15)
        let sunset = fixHour(midday + toDegrees(acos((-sin(toRadians(0.833)) - sin(toRadians(latitude)) * sin(toRadians(d))) / (cos(toRadians(latitude)) * cos(toRadians(d))))) / 15)
        let isha = fixHour(midday + toDegrees(acos((-sin(toRadians(ishaAngle)) - sin(toRadians(latitude)) * sin(toRadians(d))) / (cos(toRadians(latitude)) * cos(toRadians(d))))) / 15)
        
        return [fajr, sunrise, midday, asr, sunset, isha]
    }
    
    
    private func gregorian2Julian(_ year: Int,_ month: Int,_ day: Int) -> Double {
        var y = year
        var m = month
        
        if m <= 2 {
            y -= 1
            m += 12
        }
        let a = floor(Double(y) / 100.0)
        let b = 2 - a + floor(a / 4.0)
        let c = floor(365.25 * Double(y + 4716))
        let d = floor(30.6001 * Double(m + 1))
        
        return  Double(day ) + b + c + d - 1524.5
    }
    
    private func fixAngle(_ a: Double) -> Double {
        var b = a
        b -= 360 * floor(b / 360.0)
        if b < 0{
            b =  b + 360
        }
        return b
    }
    
    private func fixHour(_ h: Double) -> Double {
        var a = h
        a -= 24.0 * floor(a / 24.0)
        if a < 0{
            a = a + 24
        }
        return a
    }
    
    private func toDegrees(_ number: Double) -> Double {
        return number * 180 / .pi
    }
    
    func toRadians(_ number: Double) -> Double {
        return number * .pi / 180
    }
    
    func getJulianDate() -> Double {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        formatter.calendar = Calendar(identifier: .gregorian)
        let date = Date()
        let today = formatter.string(from: date).split(separator: "/")
        
        let day = Double(today.first ?? "1") ?? 1.0
        let month = Double(today[1])
        let year = Double(today.last ?? "1999")
        
        if var month, var year {
            if month <= 2 {
                year -= 1
                month += 12
            }
            
            let a = floor(year / 100.0)
            let b = 2 - a + floor(a / 4.0)
            let c = 365.25 * (year + 4716)
            let d = 30.6001 * (month + 1)
            return (floor(c) + floor(d) + day + b) - 1524.5
        }
        
        return 0
    }
    
    func main(coordinate: CLLocationCoordinate2D, month: Int, day: Int) -> [Double] {
        
        return calculateSalahTimes(
            year: 2024,
            month: month,
            day: day,
            timeZoneDiffInHour: 5,
            latitude: coordinate.latitude,
            longitude: coordinate.longitude,
            altitude: 0.0,
            fajrAngle: 15.0,
            asrShadowRatio: 2.0,
            ishaAngle: 15.0
        )
    }
}

struct SunPosition {
    let sunrise: Double
    let midday: Double
    let sunset: Double
    let sunAngle: Double
}

enum HighLatitudeMethod {
    case ANGULAR
    case MIDNIGHT
    case ONE_SEVENTH
}

class CalculateJuliaDate {
    
    static let shared = CalculateJuliaDate()
    
    func getJulianDate(year: Int, month: Int, day: Int) -> Double {
        var y = year
        var m = month
        
        if m <= 2 {
            y -= 1
            m += 12
        }
        let a = floor(Double(y) / 100.0)
        let b = 2 - a + floor(a / 4.0)
        let c = floor(365.25 * Double(y + 4716))
        let d = floor(30.6001 * Double(m + 1))
        
        return  Double(day) + b + c + d - 1524.5
    }
}


internal func formatTime(_ time: Double) -> String {
    let hourInt = formatNumber(number: Int(time))
    let minutInt = formatNumber(number: Int(time.truncatingRemainder(dividingBy: 1) * 60))
    
    return "\(hourInt):\(minutInt)"
}

func formatNumber(number: Int) -> String {
    if number >= 10 {
        return "\(number)"
    } else if number == 60 {
        return "00"
    } else {
        return "0\(number)"
    }
}

func formatNumber(_ number: Int) -> Int {
    if number >= 10 {
        return number
    } else if number == 60 {
        return 0
    } else {
        return number
    }
}
