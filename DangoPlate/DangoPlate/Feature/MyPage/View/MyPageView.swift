import SwiftUI
import KeychainAccess
struct MyPageView: View {
    @EnvironmentObject var loginManager: LoginManager
    @StateObject var viewModel = MyPageViewModel()
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing: 20) {
                    ProfileHeaderView()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                    TimelineView()
                    // 당고플레이트 섹션
                    SectionHeaderView(title: "당고플레이트")
                    MenuRow(iconName: "star", title: "가고싶다")
                    Divider()
                    MenuRow(iconName: "list.bullet", title: "마이리스트")
                    Divider()
                    MenuRow(iconName: "bookmark", title: "북마크")

                    // 고객 센터 섹션
                    SectionHeaderView(title: "고객 센터")
                    MenuRow(iconName: "questionmark.circle", title: "자주 묻는 질문")
                    Divider()
                    MenuRow(iconName: "message", title: "카카오톡 1:1 문의")
                    Divider()
                    MenuRow(iconName: "info.circle", title: "당고플레이트 안내")
                    Divider()
                    MenuRow(iconName: "doc.text", title: "서비스 약관")
                }
                .padding(.bottom,70)
            }
            .navigationBarTitle("MyPage", displayMode: .inline)
            .navigationBarItems(trailing: NavigationLink(destination: SettingView()) {
                Image(systemName: "gear")
                    .imageScale(.large)
                    .foregroundColor(.black)
                
            })
            .padding(10)
        }
        //.edgesIgnoringSafeArea(.bottom)
    }
}

struct SettingView: View {
    
    @EnvironmentObject var loginManager: LoginManager
    var body: some View {
        Button(action: {
            loginManager.logout()
        }) {
            HStack {
                Spacer()
                Text("로그아웃")
                    .foregroundColor(.red)
                Spacer()
            }
        }
        .padding()
    }
}

struct SectionHeaderView: View {
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .padding(.vertical, 10)
            Spacer()
        }
    }
}

struct TimelineView: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "clock")
                    .imageScale(.large)
                    .foregroundColor(.gray)
                Text("타임라인")
                    .font(.headline)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)

            Divider() // 구분선 추가

            HStack {
                Group{
                    VStack {
                        Text("리뷰")
                        Text("0")
                    }
                    Divider()
                    VStack {
                        Text("가고싶다")
                        Text("0")
                    }
                    Divider()
                    VStack {
                        Text("사진")
                        Text("0")
                    }
                }
                .frame(maxWidth: .infinity) // 각 요소가 동일한 너비를 갖도록 설정
            }
            .padding()
            .background(Color.white)
        }
        .frame(maxWidth: .infinity) // 전체 View가 부모의 너비를 맞춤
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 1)
    }
}



#Preview{
    MyPageView()
}
