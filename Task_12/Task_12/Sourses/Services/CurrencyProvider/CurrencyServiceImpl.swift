//
//  CurrencyProviderService.swift
//  Task_12
//
//  Created by Татьяна Лузанова on 05.11.2021.
//

class CurrencyServiceImpl {
    
    var worldCurrency: [Currency] = [Currency(name: "Euro", code: "EUR", symbol: "€"),
                                     Currency(name: "United Arab Emirates Dirham", code: "AED", symbol: "AED"),
                                     Currency(name: "Afghan Afghani", code: "AFN", symbol: "Af"),
                                     Currency(name: "Armenian Dram", code: "AMD", symbol: "AMD"),
                                     Currency(name: "Argentine Peso", code: "ARS", symbol: "AR$"),
                                     Currency(name: "US Dollar", code: "USD", symbol: "$"),
                                     Currency(name: "Australian Dollar", code: "AUD", symbol: "AU$"),
                                     Currency(name: "Azerbaijani Manat", code: "AZN", symbol: "man."),
                                     Currency(name: "Barbadian dollar", code: "BBD", symbol: "Bds$"),
                                     Currency(name: "Bulgarian Lev", code: "BGN", symbol: "BGN"),
                                     Currency(name: "Bermudian dollar", code: "BMD", symbol: "BD$"),
                                     Currency(name: "Brazilian Real", code: "BRL", symbol: "R$"),
                                     Currency(name: "Belarusian Ruble", code: "BYNL", symbol: "Br"),
                                     Currency(name: "Norwegian Krone", code: "NOK", symbol: "Nkr"),
                                     Currency(name: "Canadian Dollar Real", code: "CAD", symbol: "CA$"),
                                     Currency(name: "Chinese Yuan", code: "CNY", symbol: "CN¥"),
                                     Currency(name: "Cuban peso", code: "CUP", symbol: "$MN"),
                                     Currency(name: "Czech Republic Koruna", code: "CZK", symbol: "Kč"),
                                     Currency(name: "Egyptian Pound", code: "EGP", symbol: "EGP"),
                                     Currency(name: "British Pound Sterling", code: "GBP", symbol: "£"),
                                     Currency(name: "Georgian Lari", code: "GEL", symbol: "GEL"),
                                     Currency(name: "Hong Kong Dollar", code: "HKD", symbol: "HK$"),
                                     Currency(name: "Israeli New Sheqel", code: "ILS", symbol: "₪"),
                                     Currency(name: "Indian Rupee", code: "INR", symbol: "Rs"),
                                     Currency(name: "Japanese Yen", code: "JPY", symbol: "¥"),
                                     Currency(name: "North Korean won", code: "KPW", symbol: "₩"),
                                     Currency(name: "South Korean Won", code: "KRW", symbol: "₩"),
                                     Currency(name: "Kazakhstani Tenge", code: "KZT", symbol: "KZT"),
                                     Currency(name: "Polish Zloty", code: "PLN", symbol: "zł"),
                                     Currency(name: "Serbian Dinar", code: "RSD", symbol: "din."),
                                     Currency(name: "Russian Ruble", code: "RUB", symbol: "₽"),
                                     Currency(name: "Swedish Krona", code: "SEK", symbol: "Skr"),
                                     Currency(name: "Singapore Dollar", code: "SHP", symbol: "SH£"),
                                     Currency(name: "Thai Baht", code: "THB", symbol: "฿"),
                                     Currency(name: "Turkish Lira", code: "TRY", symbol: "TL"),
                                     Currency(name: "Ukrainian Hryvnia", code: "UAH", symbol: "₴"),
                                     Currency(name: "Vietnamese Dong", code: "VND", symbol: "₫")
    ]
    
}

extension CurrencyServiceImpl: CurrencyService {
    
    func currency() -> [Currency] {
        return worldCurrency
    }
}
