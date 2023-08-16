/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Enum.java to edit this template
 */
package Enum;

/**
 *
 * @author hossein
 */
public enum ParticipateStatus {
    USER_DEACTIVE,
    AUCTION_DEACTIVE,
    PRICE_NOTCORRECT,
    AUCTION_TIMEOUT,
    ERROR,
    SUCCESS_INSERT,
    SUCCESS_UPDATE;

    public String getStatus() {
        switch (this) {
            case USER_DEACTIVE:
                return "اکانت شما غیرفعال است";
            case AUCTION_DEACTIVE:
                return "مزایده غیر فعال است";
            case PRICE_NOTCORRECT:
                return "پیشنهاد قیمت باید بیشتر از قیمت پایه محصول و پیشنهاد قبلی باشد";
            case AUCTION_TIMEOUT:
                return "زمان مزایده ئایان یافته";
            case SUCCESS_INSERT:
                return "پیشنهاد با موفقیت ثبت شد";
            case SUCCESS_UPDATE:
                return "پیشنهاد جدید بروزرسانی شد";
            default:
                return "خطا";
        }
    }
}
