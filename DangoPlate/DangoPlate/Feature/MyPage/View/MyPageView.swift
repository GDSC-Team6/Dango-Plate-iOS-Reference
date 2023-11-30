import SwiftUI

struct MyPageView: View {
    var body: some View {
        VStack(spacing: 20) {
            ProfileHeaderView()
                .frame(maxWidth: .infinity)
                .background(Color.white)
            
            MenuListView()
                .frame(maxWidth: .infinity)
        }
        .padding()
    }
}

struct ProfileHeaderView: View {
    let profileImage: Image = Image("gasom") // 사용자의 이미지 이름으로 교체해야 함
    let username: String = "가솜"
    let followersCount: Int = 20
    let followingCount: Int = 10
    
    var body: some View {
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
}
struct CustomSpacer: View {
    var body: some View {
        Rectangle()
            .foregroundColor(.clear) // 투명한 색
            .frame(height: 10) // 원하는 높이 설정
            .listRowInsets(EdgeInsets()) // 리스트 항목의 기본 여백을 제거
    }
}
struct MenuListView: View {
    var body: some View {
        List {
            NavigationLink(destination: Text("이벤트 View")) {
                            MenuRow(iconName: "gift", title: "이벤트", count: nil)
                        }
            CustomSpacer()

                
            NavigationLink(destination: Text("구매한 EAT딜 View")) {
                MenuRow(iconName: "cart", title: "구매한 EAT딜", count: nil)
            }
            CustomSpacer()

            NavigationLink(destination: Text("EAT딜 일괄결제 View")) {
                MenuRow(iconName: "creditcard", title: "EAT딜 일괄결제", count: nil)
            }
            CustomSpacer()

            NavigationLink(destination: Text("타인라인 View")) {
                MenuRow(iconName: "person", title: "타인라인", count: "0")
            }

            NavigationLink(destination: Text("가고싶다 View")) {
                MenuRow(iconName: "star", title: "가고싶다", count: "4")
            }
            CustomSpacer()

            NavigationLink(destination: Text("마이리스트 View")) {
                MenuRow(iconName: "list.bullet", title: "마이리스트", count: nil)
            }
        }
        .listStyle(PlainListStyle()) // 기본 리스트 스타일 적용
        
    }
}
struct MenuRow: View {
    let iconName: String
    let title: String
    let count: String?

    var body: some View {
        HStack {
            Image(systemName: iconName)
            Text(title)
            Spacer()
            if let count = count {
                Text(count)
            }
        }
    }
}



#Preview{
    MyPageView()
}
