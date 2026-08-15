# INFO: Go: stock ticker
{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [ ticker ];
    file.".config/ticker/.ticker.yaml".text = ''
      show-summary: true
      show-tags: true
      show-fundamentals: true
      show-separator: true
      show-positions: true
      sort: alpha # [ alpha user value ]
      interval: 30
      currency: USD
      currency-summary-only: false
      watchlist:
        - JEPI
        - RYLD
        - QYLD
        - SCHD
        - VOO
      lots:
        - symbol: "JEPI"
          quantity: 200.0
          unit_cost: 57.55
        - symbol: "RYLD"
          quantity: 8000.0
          unit_cost: 15.39
        - symbol: "QYLD"
          quantity: 1222.0
          unit_cost: 17.74
        - symbol: "VOO"
          quantity: 29.0
          unit_cost: 649.43
      groups:
        - name: crypto
          watchlist:
            - BTC-USD # Bitcoin price via Yahoo
            - SOL.X # Solana price via Coinbase
            - XMR-USD
      colors:
        text: "#00ccff"
        text-bold: "#880022"
        text-light: "#00ff22"
        text-label: "#ee4400"
        text-line: "#00ff22"
        text-tag: "#ffaa00"
        background-tag: "#000000"
    '';
  };
}
