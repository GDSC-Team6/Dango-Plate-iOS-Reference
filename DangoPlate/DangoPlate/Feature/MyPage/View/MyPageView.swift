import SwiftUI

struct MyPageView: View {
    @EnvironmentObject var loginManager: LoginManager

    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing: 20) {
                    ProfileHeaderView()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)

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
    var body: some View {
        @EnvironmentObject var loginManager: LoginManager
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
struct ProfileHeaderView: View {
    let profileImage: Image = Image("gasom")
    let username: String = "가솜"
    let followersCount: Int = 20
    let followingCount: Int = 10
    
    var body: some View {
        VStack{
            HStack {
                VStack {
                    profileImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    
                    Text(username)
                        .font(.headline)
                        .foregroundColor(.primary)
                }
                
                Spacer() // 프로필 이미지와 팔로워 정보 사이의 간격 조절
                
                VStack {
                    Text("\(followersCount)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("팔로워")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer(minLength: 10) // 팔로워와 팔로잉 정보 사이의 간격을 10으로 설정
                
                VStack {
                    Text("\(followingCount)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("팔로잉")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer() // 팔로잉 정보와 버튼 사이의 간격 조절
                Button(action: {
                    // 버튼 클릭시 실행할 코드
                }) {
                    HStack {
                        Image(systemName: "pencil")
                            .imageScale(.medium)
                        Text("수정")
                    }
                    .padding(.horizontal, 8) // 좌우 패딩
                    .padding(.vertical, 8) // 상하 패딩
                    .overlay(
                        RoundedRectangle(cornerRadius: 39) // 둥근 모서리
                            .stroke(Color.gray, lineWidth: 1)
                    )
                }
                .foregroundColor(.gray) // 버튼 색상 설정
                
                //.padding(5) // 버튼 내부 여백 설정
            }
            .padding() // 컨텐츠 주변 여백 추가
            .frame(maxWidth: .infinity) // 최대 가로 너비 설정
            .background(Color.white) // 배경색 설정
        }
        TimelineView()
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
        //.background(Color.gray.opacity())
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
