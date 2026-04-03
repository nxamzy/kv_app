import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return AppLocalizations(Localizations.localeOf(context));
  }

  static const Map<String, Map<String, String>> _localizedValues = {
    'uz': {
      'group': 'Guruh',
      'group_deleted': 'Guruh o\'chirildi',
      'expense_history': 'Xarajatlar tarixi',
      'delete_group_title': 'Guruhni o\'chirish',
      'delete_group_msg':
          'Haqiqatan ham o\'chirmoqchimisiz? Barcha xarajatlar ham o\'chib ketadi.',
      'loading': 'Yuklanmoqda...',
      'no_name': 'Nomsiz',
      'group_type_suffix': 'guruhi',
      'opened_date': 'Ochilgan sana:',
      'members_count': 'A\'zolar:',
      'count_unit': 'ta',
      'no_expenses': 'Xarajatlar yo\'q',
      'settings': 'Sozlamalar',
      'general': 'Umumiy',
      'dark_mode': 'Tungi rejim',
      'language': 'Tilni tanlash',
      'notifications': 'Bildirishnomalar',
      'push_notifications': 'Push-bildirishnomalar',
      'help': 'Yordam',
      'faq': 'Savol va javoblar',
      'about_app': 'Ilova haqida',
      'logout': 'Hisobdan chiqish',
      'logout_confirm_title': 'Chiqish',
      'logout_confirm_msg': 'Haqiqatan ham hisobingizdan chiqmoqchimisiz?',
      'user_default': 'Foydalanuvchi',
      'create_group': 'Guruh yaratish',
      'my_groups': 'Guruhlarim',
      'loading_error': 'Ma\'lumot yuklashda xatolik',
      'error_text': 'Xato',
      'friend_default': 'Do\'stim',
      'expense_details': 'Xarajat tafsiloti',
      'unknown_product': 'Noma\'lum mahsulot',
      'payer': 'To\'lovchi',
      'date_label': 'Sana',
      'date_not_found': 'Sana topilmadi',
      'delete_this_expense': 'Ushbu xarajatni o\'chirish',
      'delete_confirm_title': 'O\'chirish',
      'delete_confirm_msg': 'Ushbu harajatni o\'chirmoqchimisiz?',
      'cancel': 'Bekor qilish',
      'delete': 'O\'chirish',
      'expense_deleted': 'Xarajat o\'chirildi',
      'unknown_person': 'Noma\'lum',
      'select_category': 'Kategoriya tanlang',
      'entertainment': 'Ko\'ngilochar',
      'food_drink': 'Oziq-ovqat va ichimliklar',
      'home': 'Uy',
      'transportation': 'Transport',
      'expense': 'Xarajat',
      'you_paid': 'Siz to\'ladingiz',
      'friend_paid': 'to\'ladi',
      'group_expense': 'Guruh xarajati',
      'friend': 'Do\'st',
      'recent_expenses': 'Oxirgi xarajatlar',
      'selected_group': 'Tanlangan guruh',
      'all': 'Hammasi',
      'no_expenses_yet': 'Hali xarajatlar yo\'q',
      'hello': 'Salom',
      'i_owe_label': 'Men berishim kerak',
      'owed_to_me_label': 'Menga berishi kerak',
      'currency_som': 'so\'m',
      'select_language_title': 'Tilni tanlang',
      'version_txt': 'Versiya',
      'account_settings': 'Hisob sozlamalari',
      'save_changes': 'O\'zgarishlarni saqlash',
      'settings_saved': 'Ma\'lumotlar muvaffaqiyatli saqlandi!',
      'no_data_found': 'Ma\'lumot topilmadi',
      'full_name': 'To\'liq ism',
      'email_address': 'Email manzili',
      'phone_number': 'Telefon raqami',
      'password': 'Parol',
      'confirm_phone': 'Telefon raqamini tasdiqlash',
      'name_not_entered': 'Ism kiritilmagan',
      'unconfirmed': '(tasdiqlanmagan)',
      'primary': 'Asosiy',
      'add_new_email': 'Yangi email qo\'shish',
      'current_password_hint': 'Joriy parolingiz',
      'new_password_hint': 'Yangi parol yarating',
      'default_currency': 'Asosiy valyuta',
      'select_currency': 'Valyutani tanlang',
      'uzbekistan': 'O\'zbekiston',
      'usa': 'AQSH',
      'advanced_feature': 'Qo\'shimcha imkoniyatlar',
      'your_account': 'Sizning hisobingiz',
      'close_account': 'Hisobni o\'chirish',

      'logout_confirm_desc': 'Haqiqatan ham hisobingizdan chiqmoqchimisiz?',
      'friends_tab': "Do'stlar",
      'home_tab': 'Asosiy',
      'account_tab': 'Hisob',
      'add_friend': "Do'st qo'shish",
      'user_not_found': 'Foydalanuvchi topilmadi',
      'back': 'Orqaga qaytish',
      'do_you_want_to_add':
          "Ushbu foydalanuvchini do'stlaringiz ro'yxatiga qo'shmoqchimisiz?",
      'confirm_friendship': "Do'stlikni tasdiqlash",

      'friend_added_success': "Do'stlik muvaffaqiyatli o'rnatildi!",
      'error_occurred': 'Xatolik yuz berdi',
      'unknown': "Noma'lum",

      'my_code': 'Mening kodim',
      'share_code': 'Kodni ulashish',
      'copy_code': 'Kodni nusxalash',
      'change_code': 'Kodni almashtirish',
      'link_copied': 'Link nusxalandi!',
      'change_code_title': 'Kodni almashtirish',
      'change_code_desc':
          'Eski kodingiz ishlamay qolishi mumkin. Haqiqatan ham yangi kod yaratmoqchimisiz?',
      'new_code_created': 'Yangi kod yaratildi!',
      'qr_warning':
          "Bu kod orqali istalgan kishi sizni PlanWay'da do'st sifatida qo'shishi mumkin. Uni faqat ishonchli insonlar bilan ulashing.",

      'share_message': "PlanWay'da menga do'st bo'ling! Mening kodim: ",

      'you_are_owed': 'Sizga berishi kerak',
      'you_owe': 'Siz berishingiz kerak',
      'my_account': 'Hisobingiz',

      'select_language': 'Tilni tanlang',
      'version': 'Versiya',

      'new_group': 'Yangi guruh',
      'group_name': 'Guruh nomi',
      'group_name_hint': 'Masalan: Susanbil',
      'group_type': 'Guruh turi',

      'enter_group_name': 'Guruh nomini kiriting!',

      'travel': 'Sayohat',
      'friends': "Do'stlar",
      'other': 'Boshqa',

      'add_expense': 'Yangi xarajat qo\'shish',
      'for_which_group': 'Qaysi guruh uchun?',
      'select_group': 'Guruhni tanlang',
      'expense_name': 'Xarajat nomi',
      'expense_hint': 'Nima sotib oldingiz? (Masalan: Osh)',
      'amount': 'Summa',
      'amount_hint': 'Summa (UZS)',
      'save': 'Saqlash',
      'no_group_name': 'Hali guruhga nom bermadingiz!',
      'enter_amount_group': 'Summani kiriting va guruhni tanlang!',
      'no_friends_yet': 'Hozircha do\'stlar yo\'q',
      'invite_friends_desc':
          'Do\'stlaringizni taklif qiling va moliyaviy rejalarni birga boshqaring!',
      'send_invitation': 'Taklifnoma yuborish',
    },
    'ru': {
      'group': 'Группа',
      'group_deleted': 'Группа удалена',
      'expense_history': 'История расходов',
      'delete_group_title': 'Удалить группу',
      'delete_group_msg':
          'Вы действительно хотите удалить? Все расходы также будут удалены.',
      'loading': 'Загрузка...',
      'no_name': 'Без названия',
      'group_type_suffix': 'группа',
      'opened_date': 'Дата открытия:',
      'members_count': 'Участники:',
      'count_unit': 'чел',
      'no_expenses': 'Расходов нет',
      'settings': 'Настройки',
      'general': 'Общие',
      'dark_mode': 'Темный режим',
      'language': 'Выбор языка',
      'notifications': 'Уведомления',
      'push_notifications': 'Push-уведомления',
      'help': 'Помощь',
      'faq': 'Вопросы и ответы',
      'about_app': 'О приложении',
      'logout': 'Выйти из аккаунта',
      'logout_confirm_title': 'Выход',
      'logout_confirm_msg': 'Вы действительно хотите выйти из аккаунта?',
      'user_default': 'Пользователь',
      'create_group': 'Создать группу',
      'my_groups': 'Мои группы',
      'loading_error': 'Ошибка загрузки данных',
      'error_text': 'Ошибка',
      'friend_default': 'Друг',
      'expense_details': 'Детали расхода',
      'unknown_product': 'Неизвестный продукт',
      'payer': 'Плательщик',
      'date_label': 'Дата',
      'date_not_found': 'Дата не найдена',
      'delete_this_expense': 'Удалить этот расход',
      'delete_confirm_title': 'Удаление',
      'delete_confirm_msg': 'Вы действительно хотите удалить этот расход?',
      'cancel': 'Отмена',
      'delete': 'Удалить',
      'expense_deleted': 'Расход удален',
      'unknown_person': 'Неизвестно',
      'select_category': 'Выберите категорию',
      'entertainment': 'Развлечения',
      'food_drink': 'Еда и напитки',
      'home': 'Дом',
      'transportation': 'Транспорт',
      'expense': 'Расход',
      'you_paid': 'Вы заплатили',
      'friend_paid': 'оплатил(а)',
      'group_expense': 'Групповой расход',
      'friend': 'Друг',
      'recent_expenses': 'Последние расходы',
      'selected_group': 'Выбранная группа',
      'all': 'Все',
      'no_expenses_yet': 'Расходов пока нет',
      'hello': 'Привет',
      'i_owe_label': 'Я должен',
      'owed_to_me_label': 'Мне должны',
      'currency_som': 'сум',
      'select_language_title': 'Выберите язык',
      'version_txt': 'Версия',
      'account_settings': 'Настройки аккаунта',
      'save_changes': 'Сохранить изменения',
      'settings_saved': 'Настройки успешно сохранены!',
      'no_data_found': 'Данные не найдены',
      'full_name': 'Полное имя',
      'email_address': 'Email адрес',
      'phone_number': 'Номер телефона',
      'password': 'Пароль',
      'confirm_phone': 'Подтвердите номер телефона',
      'name_not_entered': 'Имя не введено',
      'unconfirmed': '(не подтверждено)',
      'primary': 'Основной',
      'add_new_email': 'Добавить новый email',
      'current_password_hint': 'Ваш текущий пароль',
      'new_password_hint': 'Создайте новый пароль',
      'default_currency': 'Валюта по умолчанию',
      'select_currency': 'Выберите валюту',
      'uzbekistan': 'Узбекистан',
      'usa': 'США',
      'advanced_feature': 'Дополнительные функции',
      'your_account': 'Ваш аккаунт',
      'close_account': 'Закрыть аккаунт',

      'logout_confirm_desc':
          'Вы действительно хотите выйти из своего аккаунта?',
      'friends_tab': 'Друзья',
      'home_tab': 'Главная',
      'account_tab': 'Аккаунт',
      'add_friend': 'Добавить друга',
      'user_not_found': 'Пользователь не найден',
      'back': 'Вернуться назад',
      'do_you_want_to_add':
          'Вы хотите добавить этого пользователя в список друзей?',
      'confirm_friendship': 'Подтвердить дружбу',

      'friend_added_success': 'Дружба успешно установлена!',
      'error_occurred': 'Произошла ошибка',
      'unknown': 'Неизвестно',

      'my_code': 'Мой код',
      'share_code': 'Поделиться кодом',
      'copy_code': 'Копировать код',
      'change_code': 'Сменить код',
      'link_copied': 'Ссылка скопирована!',
      'change_code_title': 'Смена кода',
      'change_code_desc':
          'Старый код может перестать работать. Вы уверены, что хотите создать новый код?',
      'new_code_created': 'Новый код создан!',
      'qr_warning':
          'С помощью этого кода любой может добавить вас в друзья в PlanWay. Делитесь им только с доверенными людьми.',

      'share_message': "Станьте моим другом в PlanWay! Мой код: ",

      'you_are_owed': 'Должен вам',
      'you_owe': 'Вы должны',
      'my_account': 'Ваш аккаунт',

      'select_language': 'Выберите язык',
      'version': 'Версия',

      'new_group': 'Новая группа',
      'group_name': 'Название группы',
      'group_name_hint': 'Например: Семья',
      'group_type': 'Тип группы',

      'enter_group_name': 'Введите название группы!',

      'travel': 'Путешествие',
      'friends': 'Друзья',
      'other': 'Другое',

      'add_expense': 'Добавить расход',
      'for_which_group': 'Для какой группы?',
      'select_group': 'Выберите группу',
      'expense_name': 'Название расхода',
      'expense_hint': 'Что вы купили? (Например: Обед)',
      'amount': 'Сумма',
      'amount_hint': 'Сумма (UZS)',
      'save': 'Сохранить',
      'no_group_name': 'Вы еще не дали название группе!',
      'enter_amount_group': 'Введите сумму и выберите группу!',
      'no_friends_yet': 'Друзей пока нет',
      'invite_friends_desc':
          'Приглашайте друзей и управляйте финансовыми планами вместе!',
      'send_invitation': 'Отправить приглашение',
    },
    'en': {
      'group': 'Group',
      'group_deleted': 'Group deleted',
      'expense_history': 'Expense history',
      'delete_group_title': 'Delete group',
      'delete_group_msg':
          'Are you sure you want to delete? All expenses will also be deleted.',
      'loading': 'Loading...',
      'no_name': 'Unnamed',
      'group_type_suffix': 'group',
      'opened_date': 'Opened date:',
      'members_count': 'Members:',
      'count_unit': 'pcs',
      'no_expenses': 'No expenses',
      'settings': 'Settings',
      'general': 'General',
      'dark_mode': 'Dark Mode',
      'language': 'Language',
      'notifications': 'Notifications',
      'push_notifications': 'Push Notifications',
      'help': 'Help',
      'faq': 'FAQ',
      'about_app': 'About App',
      'logout': 'Logout',
      'logout_confirm_title': 'Logout',
      'logout_confirm_msg':
          'Are you sure you want to logout from your account?',
      'user_default': 'User',
      'create_group': 'Create group',
      'my_groups': 'My groups',
      'loading_error': 'Error loading data',
      'error_text': 'Error',
      'friend_default': 'Friend',
      'expense_details': 'Expense details',
      'unknown_product': 'Unknown item',
      'payer': 'Payer',
      'date_label': 'Date',
      'date_not_found': 'Date not found',
      'delete_this_expense': 'Delete this expense',
      'delete_confirm_title': 'Delete',
      'delete_confirm_msg': 'Are you sure you want to delete this expense?',
      'cancel': 'Cancel',
      'delete': 'Delete',
      'expense_deleted': 'Expense deleted',
      'unknown_person': 'Unknown',
      'select_category': 'Select category',
      'entertainment': 'Entertainment',
      'food_drink': 'Food and drink',
      'home': 'Home',
      'transportation': 'Transportation',
      'expense': 'Expense',
      'you_paid': 'You paid',
      'friend_paid': 'paid',
      'group_expense': 'Group expense',
      'friend': 'Friend',
      'recent_expenses': 'Recent expenses',
      'selected_group': 'Selected group',
      'all': 'All',
      'no_expenses_yet': 'No expenses yet',
      'hello': 'Hello',
      'i_owe_label': 'I owe',
      'owed_to_me_label': 'Owed to me',
      'currency_som': 'sum',
      'select_language_title': 'Select Language',
      'version_txt': 'Version',
      'account_settings': 'Account settings',
      'save_changes': 'Save changes',
      'settings_saved': 'Settings saved successfully!',
      'no_data_found': 'No data found',
      'full_name': 'Full name',
      'email_address': 'Email address',
      'phone_number': 'Phone number',
      'password': 'Password',
      'confirm_phone': 'Confirm your phone number',
      'name_not_entered': 'Name not entered',
      'unconfirmed': '(unconfirmed)',
      'primary': 'Primary',
      'add_new_email': 'Add a new email',
      'current_password_hint': 'Your current password',
      'new_password_hint': 'Create a new password',
      'default_currency': 'Default currency',
      'select_currency': 'Select currency',
      'uzbekistan': 'Uzbekistan',
      'usa': 'USA',

      'advanced_feature': 'Advanced feature',
      'your_account': 'Your account',
      'close_account': 'Close your account',

      'logout_confirm_desc':
          'Are you sure you want to log out of your account?',
      'friends_tab': 'Friends',
      'home_tab': 'Home',
      'account_tab': 'Account',
      'my_account': 'Your Account',

      'select_language': 'Select Language',
      'version': 'Version',

      'new_group': 'New Group',
      'group_name': 'Group Name',
      'group_name_hint': 'Ex: Team Alpha',
      'group_type': 'Group Type',

      'enter_group_name': 'Please enter a group name!',

      'travel': 'Travel',
      'friends': 'Friends',
      'other': 'Other',

      'add_expense': 'Add New Expense',
      'for_which_group': 'For which group?',
      'select_group': 'Select group',
      'expense_name': 'Expense Name',
      'expense_hint': 'What did you buy? (Ex: Dinner)',
      'amount': 'Amount',
      'amount_hint': 'Amount (USD/UZS)',
      'save': 'Save',
      'no_group_name': 'You haven\'t named the group yet!',
      'enter_amount_group': 'Enter amount and select a group!',

      'add_friend': 'Add Friend',
      'user_not_found': 'User not found',
      'back': 'Go Back',
      'do_you_want_to_add':
          'Do you want to add this user to your friends list?',
      'confirm_friendship': 'Confirm Friendship',

      'friend_added_success': 'Friend successfully added!',
      'error_occurred': 'An error occurred',
      'unknown': 'Unknown',

      'my_code': 'My Code',
      'share_code': 'Share Code',
      'copy_code': 'Copy Code',
      'change_code': 'Change Code',
      'link_copied': 'Link copied to clipboard!',
      'change_code_title': 'Change Invite Code',
      'change_code_desc':
          'Your old code may stop working. Are you sure you want to create a new one?',
      'new_code_created': 'New code generated!',
      'qr_warning':
          'With this code, anyone can add you as a friend on PlanWay. Share it only with people you trust.',

      'share_message': 'Connect with me on PlanWay! My code is: ',

      'you_are_owed': 'Owes you',
      'you_owe': 'You owe',
      'no_friends_yet': 'No friends yet',
      'invite_friends_desc':
          'Invite your friends and manage financial plans together!',
      'send_invitation': 'Send Invitation',
    },
  };
  String get createGroup => _localizedValues[_code]!['create_group']!;
  String get myGroups => _localizedValues[_code]!['my_groups']!;
  String get loadingError => _localizedValues[_code]!['loading_error']!;
  String get errorText => _localizedValues[_code]!['error_text']!;
  String get friendDefault => _localizedValues[_code]!['friend_default']!;
  String get expenseDetails => _localizedValues[_code]!['expense_details']!;
  String get unknownProduct => _localizedValues[_code]!['unknown_product']!;
  String get payerLabel => _localizedValues[_code]!['payer']!;
  String get dateLabel => _localizedValues[_code]!['date_label']!;
  String get dateNotFound => _localizedValues[_code]!['date_not_found']!;
  String get deleteThisExpense =>
      _localizedValues[_code]!['delete_this_expense']!;
  String get deleteConfirmTitle =>
      _localizedValues[_code]!['delete_confirm_title']!;
  String get deleteConfirmMsg =>
      _localizedValues[_code]!['delete_confirm_msg']!;
  String get cancelBtn => _localizedValues[_code]!['cancel']!;
  String get deleteBtn => _localizedValues[_code]!['delete']!;
  String get expenseDeletedMsg => _localizedValues[_code]!['expense_deleted']!;
  String get unknownPerson => _localizedValues[_code]!['unknown_person']!;
  String get selectCategory => _localizedValues[_code]!['select_category']!;
  String get entertainment => _localizedValues[_code]!['entertainment']!;
  String get foodDrink => _localizedValues[_code]!['food_drink']!;
  String get homeGroup => _localizedValues[_code]!['home']!;
  String get transportation => _localizedValues[_code]!['transportation']!;
  String get expense => _localizedValues[_code]!['expense']!;
  String get youPaid => _localizedValues[_code]!['you_paid']!;
  String get friendPaid => _localizedValues[_code]!['friend_paid']!;
  String get groupExpense => _localizedValues[_code]!['group_expense']!;
  String get friend => _localizedValues[_code]!['friend']!;
  String get recentExpenses => _localizedValues[_code]!['recent_expenses']!;
  String get selectedGroupLabel => _localizedValues[_code]!['selected_group']!;
  String get all => _localizedValues[_code]!['all']!;
  String get noExpensesYet => _localizedValues[_code]!['no_expenses_yet']!;
  String get fullNameLabel => _localizedValues[_code]!['full_name']!;
  String get emailAddressLabel => _localizedValues[_code]!['email_address']!;
  String get phoneNumberLabel => _localizedValues[_code]!['phone_number']!;
  String get passwordLabel => _localizedValues[_code]!['password']!;
  String get confirmPhone => _localizedValues[_code]!['confirm_phone']!;
  String get nameNotEntered => _localizedValues[_code]!['name_not_entered']!;
  String get unconfirmed => _localizedValues[_code]!['unconfirmed']!;
  String get primaryBadge => _localizedValues[_code]!['primary']!;
  String get addNewEmail => _localizedValues[_code]!['add_new_email']!;
  String get currentPasswordHint =>
      _localizedValues[_code]!['current_password_hint']!;
  String get newPasswordHint => _localizedValues[_code]!['new_password_hint']!;
  String get noFriendsYet => _localizedValues[_code]!['no_friends_yet']!;
  String get inviteFriendsDesc =>
      _localizedValues[_code]!['invite_friends_desc']!;
  String get sendInvitation => _localizedValues[_code]!['send_invitation']!;

  String get addFriend => _localizedValues[_code]!['add_friend']!;
  String get userNotFound => _localizedValues[_code]!['user_not_found']!;
  String get back => _localizedValues[_code]!['back']!;
  String get doYouWantToAdd => _localizedValues[_code]!['do_you_want_to_add']!;
  String get confirmFriendship =>
      _localizedValues[_code]!['confirm_friendship']!;
  String get cancel => _localizedValues[_code]!['cancel']!;
  String get friendAddedSuccess =>
      _localizedValues[_code]!['friend_added_success']!;
  String get errorOccurred => _localizedValues[_code]!['error_occurred']!;
  String get unknown => _localizedValues[_code]!['unknown']!;

  String get myCode => _localizedValues[_code]!['my_code']!;
  String get shareCode => _localizedValues[_code]!['share_code']!;
  String get copyCode => _localizedValues[_code]!['copy_code']!;
  String get changeCode => _localizedValues[_code]!['change_code']!;
  String get linkCopied => _localizedValues[_code]!['link_copied']!;
  String get changeCodeTitle => _localizedValues[_code]!['change_code_title']!;
  String get changeCodeDesc => _localizedValues[_code]!['change_code_desc']!;
  String get newCodeCreated => _localizedValues[_code]!['new_code_created']!;
  String get qrWarning => _localizedValues[_code]!['qr_warning']!;
  String get loading => _localizedValues[_code]!['loading']!;
  String get shareMessage => _localizedValues[_code]!['share_message']!;

  String get youAreOwed => _localizedValues[_code]!['you_are_owed']!;
  String get youOwe => _localizedValues[_code]!['you_owe']!;
  String get _code => locale.languageCode;
  String get groupLabel => _localizedValues[_code]!['group']!;
  String get groupDeletedMsg => _localizedValues[_code]!['group_deleted']!;
  String get expenseHistory => _localizedValues[_code]!['expense_history']!;
  String get deleteGroupTitle =>
      _localizedValues[_code]!['delete_group_title']!;
  String get deleteGroupMsg => _localizedValues[_code]!['delete_group_msg']!;
  String get loadingLabel => _localizedValues[_code]!['loading']!;
  String get noName => _localizedValues[_code]!['no_name']!;
  String get groupTypeSuffix => _localizedValues[_code]!['group_type_suffix']!;
  String get openedDate => _localizedValues[_code]!['opened_date']!;
  String get membersCount => _localizedValues[_code]!['members_count']!;
  String get countUnit => _localizedValues[_code]!['count_unit']!;
  String get noExpenses => _localizedValues[_code]!['no_expenses']!;
  String get myAccount => _localizedValues[_code]!['my_account']!;
  String get general => _localizedValues[_code]!['general']!;
  String get darkMode => _localizedValues[_code]!['dark_mode']!;
  String get language => _localizedValues[_code]!['language']!;
  String get notifications => _localizedValues[_code]!['notifications']!;
  String get pushNotifications =>
      _localizedValues[_code]!['push_notifications']!;
  String get help => _localizedValues[_code]!['help']!;
  String get faq => _localizedValues[_code]!['faq']!;
  String get aboutApp => _localizedValues[_code]!['about_app']!;
  String get selectLanguage => _localizedValues[_code]!['select_language']!;
  String get versionTxt => _localizedValues[_code]!['version']!;

  String get newGroup => _localizedValues[_code]!['new_group']!;
  String get groupName => _localizedValues[_code]!['group_name']!;
  String get groupNameHint => _localizedValues[_code]!['group_name_hint']!;
  String get groupType => _localizedValues[_code]!['group_type']!;

  String get enterGroupName => _localizedValues[_code]!['enter_group_name']!;
  String get home => _localizedValues[_code]!['home']!;
  String get travel => _localizedValues[_code]!['travel']!;
  String get friends => _localizedValues[_code]!['friends']!;
  String get other => _localizedValues[_code]!['other']!;

  String get addExpense => _localizedValues[_code]!['add_expense']!;
  String get forWhichGroup => _localizedValues[_code]!['for_which_group']!;
  String get selectGroup => _localizedValues[_code]!['select_group']!;
  String get expenseName => _localizedValues[_code]!['expense_name']!;
  String get expenseHint => _localizedValues[_code]!['expense_hint']!;
  String get amount => _localizedValues[_code]!['amount']!;
  String get amountHint => _localizedValues[_code]!['amount_hint']!;
  String get save => _localizedValues[_code]!['save']!;
  String get noGroupName => _localizedValues[_code]!['no_group_name']!;
  String get enterAmountGroup =>
      _localizedValues[_code]!['enter_amount_group']!;
  String get friendsTab => _localizedValues[_code]!['friends_tab']!;
  String get homeTab => _localizedValues[_code]!['home_tab']!;
  String get accountTab => _localizedValues[_code]!['account_tab']!;
  String get advancedFeature => _localizedValues[_code]!['advanced_feature']!;
  String get yourAccount => _localizedValues[_code]!['your_account']!;
  String get closeAccount => _localizedValues[_code]!['close_account']!;
  String get logout => _localizedValues[_code]!['logout']!;
  String get logoutConfirmTitle =>
      _localizedValues[_code]!['logout_confirm_title']!;
  String get logoutConfirmDesc =>
      _localizedValues[_code]!['logout_confirm_desc']!;
  String get defaultCurrency => _localizedValues[_code]!['default_currency']!;
  String get selectCurrency => _localizedValues[_code]!['select_currency']!;
  String get uzbekistan => _localizedValues[_code]!['uzbekistan']!;
  String get usa => _localizedValues[_code]!['usa']!;
  String get accountSettings => _localizedValues[_code]!['account_settings']!;
  String get saveChanges => _localizedValues[_code]!['save_changes']!;
  String get settingsSaved => _localizedValues[_code]!['settings_saved']!;
  String get noDataFound => _localizedValues[_code]!['no_data_found']!;
  String get selectLanguageTitle =>
      _localizedValues[_code]!['select_language_title']!;
  String get hello => _localizedValues[_code]!['hello']!;
  String get iOweLabel => _localizedValues[_code]!['i_owe_label']!;
  String get owedToMeLabel => _localizedValues[_code]!['owed_to_me_label']!;
  String get currencySom => _localizedValues[_code]!['currency_som']!;
  String get settings => _localizedValues[_code]!['settings']!;
  String get dark_mode => _localizedValues[_code]!['dark_mode']!;

  String get push_notifications =>
      _localizedValues[_code]!['push_notifications']!;

  String get about_app => _localizedValues[_code]!['about_app']!;

  String get logout_confirm_title =>
      _localizedValues[_code]!['logout_confirm_title']!;
  String get logout_confirm_msg =>
      _localizedValues[_code]!['logout_confirm_msg']!;
  String get user_default => _localizedValues[_code]!['user_default']!;
}
