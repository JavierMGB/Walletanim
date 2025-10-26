import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            WalletView()
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        NavigationLink(destination: SettingsView()) {
                            Image(systemName: "line.3.horizontal")
                                .imageScale(.large)
                        }
                    }
                }
        }
            
        
    }
}

struct WalletView: View {
    let cards: [Card] = [
        Card(color: .blue, name: "Tarjeta Azul", icon: "creditcard.fill", balance: "125,30 €"),
        Card(color: .purple, name: "Tarjeta Morada", icon: "bolt.fill", balance: "642,00 €"),
        Card(color: .orange, name: "Tarjeta Naranja", icon: "sun.max.fill", balance: "89,90 €")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(cards) { card in
                    NavigationLink(destination: CardDetailView(card: card)) {
                        CardView(card: card)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
        }
        .navigationTitle(Text("Wallet"))
    }
}

struct Card: Identifiable {
    let id = UUID()
    let color: Color
    let name: String
    let icon: String
    let balance: String
}

struct CardView: View {
    let card: Card
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(card.color.gradient)
            .frame(width: 300, height: 180)
            .shadow(radius: 5)
            .overlay(
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: card.icon)
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                        Spacer()
                    }
                    Spacer()
                    Text(card.name)
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(card.balance)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                    .padding()
            )
    }
}


struct CardDetailView: View {
    let card: Card
    @State private var animate = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(card.color.gradient)
                        .frame(width: 300, height: 180)
                        .shadow(radius: 5)
                        .overlay(
                            VStack(alignment: .leading) {
                                HStack {
                                    Image(systemName: card.icon)
                                        .font(.system(size: 30))
                                        .foregroundColor(.white)
                                    Spacer()
                                }
                                Spacer()
                                Text(card.name)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text(card.balance)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                                .padding()
                        )
                    
            
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.blue.opacity(0.6), lineWidth: 3)
                        .scaleEffect(animate ? 1.3 : 1)
                        .opacity(animate ? 0 : 1)
                        .frame(width: 300, height: 180)
                        .animation(Animation.easeOut(duration: 1.2).repeatForever(autoreverses: false), value: animate)
                }
                .padding()
                .onAppear { animate = true }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(card.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Historial de transacciones")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    ForEach(0..<5) { i in
                        HStack {
                            Text("Compra #\(i + 1)")
                            Spacer()
                            Text("-\(Int.random(in: 5...100)) €")
                                .foregroundColor(.gray)
                        }
                        Divider()
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
      
        .navigationTitle(card.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SettingsView: View {
    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack(spacing: 15) {
                        Image("Image Asset")
                            .symbolRenderingMode(.multicolor)
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.gray)
                            .cornerRadius(100)
                        
                        VStack(alignment: .leading) {
                            Text("Javier MGB")
                                .font(.headline)
                            Text("usuario@ejemplo.com")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 5)
                }
                
                Section(header: Text("Gestión")) {
                    NavigationLink(destination: Text("Gestionar tarjetas")) {
                        Label("Gestionar tarjetas", systemImage: "creditcard.fill")
                    }
                    NavigationLink(destination: Text("Configuración")) {
                        Label("Configuración", systemImage: "gearshape.fill")
                    }
                }
                
                Section(header: Text("Ayuda")) {
                    NavigationLink(destination: Text("Centro de ayuda")) {
                        Label("Ayuda", systemImage: "questionmark.circle.fill")
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Cuenta")
    }
}

#Preview {
    ContentView()
}
