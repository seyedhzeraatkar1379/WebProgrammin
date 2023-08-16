package Enum;

public enum StatusQuery {
    SUCCESS,
    FAILD,
    FAILD_DEPENDENCY,
    PARAMETER_NOT_VALID,
    RECORD_EXIST,
    SUCCESS_IMAGE_FAILD,
    PASSWORD_INCORRECT,
    NEW_PASSWORD_RETRY_INCORRECT,
    USERNAME_PASSWORD_INCORRECT,
    COMMITMENT_NOT_ACCEPT,
    PASSWORD_EQUAL_NEWPASS;

    public String getSize() {

        // this will refer to the object SMALL
        switch (this) {
            case SUCCESS:
                return "عملیات موفقیت آمیز";
            case FAILD:
                return "خطا!";
            case FAILD_DEPENDENCY:
                return "این رکورد وابستگی دارد";
            case PARAMETER_NOT_VALID:
                return "اطلاعات ورودی اشتباه است";
            case RECORD_EXIST:
                return "اطلاعات تکراری است";
            case SUCCESS_IMAGE_FAILD:
                return "رکورد ایجاد اما تصویری ثبت نشده است";
            case PASSWORD_INCORRECT:
                return "رمز ورود اشتباه است";
            case NEW_PASSWORD_RETRY_INCORRECT:
                return "تکرار رمز عبور مطابقت ندارد";
            case USERNAME_PASSWORD_INCORRECT:
                return "نام کاربری و رمز عبور صحیح نیست";
            case COMMITMENT_NOT_ACCEPT:
                return "قوانین سایت را مطالعه و تایید کنید";
            case PASSWORD_EQUAL_NEWPASS:
                return "رمز عبور جدید باید با رمز قبلی متفاوت باشد";
            default:
                return null;
        }
    }
}
