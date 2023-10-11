# Konfiguracja środowiska  testowego

## Tabela serwerów
|Nazwa serwera | Rola serwera      | Adres IP serwera| Uwagi          |
|--------------|-------------------|-----------------|----------------|
|DC            | kontroler domeny  | 192.168.8.1     | Windows Core   |
|SQL01         | Serwer SQL        | 192.168.8.2     | Windows Core   |
|SQL02         | Serwer SQL        | 192.168.8.3     | Windows Core   |
|SQL03         | Serwer SQL        | 192.168.8.4     | Windows Core   |
|CLIENT        | Windows 10        | 192.168.8.5     | Windows 10     |
|FS            | File Serwer       | 192.168.8.6     | Windows Core   |

## Tabela zasobów
|Nazwa zasobu   | Adres zasobu | Opis zasobu |
|---------------|--------------|-------------|
|Scripts        | \\\DC\scripts | Skrypty     |
|Tools          | \\\DC\Tools   | Narzędzia   |
