# 家庭血压 Dashboard

一个无账号登录、适合手机和电脑使用的家庭血压记录网页。GitHub Pages 负责网页托管，Supabase 负责跨设备数据同步。

## 功能

- Yihao / Wenqi 独立记录与筛选
- 高压、低压、心率、测量时间和备注
- 日历按人显示每日多次测量的平均值
- 点击日期查看当天每次测量，并可编辑或删除
- 7 天 / 1 个月趋势图
- 家庭访问密钥经浏览器 SHA-256 后用于隔离数据，不需要注册账号
- Supabase 未配置时自动进入本地演示模式

## 1. 配置 Supabase

1. 创建 Supabase 项目。
2. 在 SQL Editor 运行 `supabase-setup.sql`。
3. 打开 Project Settings / API，复制 Project URL 和 Publishable key。
4. 填入 `config.js`。Publishable key 可以放在前端；不要使用 Secret key 或 Service Role key。
5. 打开网页，在设置中输入同一个家庭访问密钥；每台设备只需设置一次。

## 2. 部署 GitHub Pages

1. 新建 GitHub repository，将本项目全部文件上传到仓库根目录。
2. Repository → Settings → Pages。
3. Build and deployment 选择 **Deploy from a branch**，Branch 选择 `main` / `(root)`。
4. 保存后约 1–3 分钟获得 `https://你的用户名.github.io/仓库名/`。

## 安全说明

- 至少使用 16 位随机家庭密钥，并只发给家庭成员。
- 数据库启用了 RLS；请求必须携带匹配的家庭密钥哈希。
- 不要把原始家庭密钥写入 GitHub、`config.js` 或数据库脚本。
- 这是个人记录工具，不替代医生诊断。异常或伴随不适时请及时咨询医生。
