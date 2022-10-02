// API

const API_BASE = "https://tchipinapi.azurewebsites.net/";

const API_REGISTER = "Users/register";
const API_LOGIN = "Users/authenticate";
const API_GET_USER = "Users";
const API_UPDATE_PASSWORD = "Users/UpdatePassword";
const API_UPDATE_INFO = "Users/UpdatePersonalInfo";
const API_UPLOAD_USER_IMAGE = "Users/UploadUserImage";

const API_GET_POT_TYPES = "PotType/GetAll";
const API_GET_POT_COVERS = "PotCoverPhoto/GetByTypeId";
const API_CREATE_POT_ANONYMOUS = "Pot/CreatPotAnonymous";
const API_CREATE_POT = "Pot/CreatPot";
const API_GET_POTS = "Pot/GetAllPotCreated";
const API_GET_INVITED_POTS = "Pot/GetAllPotInvited";
const API_GET_OFFERED_POTS = "Pot/GetAllPotOffered";
const API_SEND_POT_INVITATION = "Pot/sendInvitationforpot";
const API_OFFER_POT_PARTICIPANT = "Pot/OfferPotForParticipant";
const API_OFFER_POT_FRIEND = "Pot/OfferPotForFriend";
const API_CREATE_CHECKOUT_SESSION = "PaymentIntentApi/CreateCheckOutSession";

const API_RESTAURANTS = "/api/v1/restaurants";
const API_MENUS = "/api/v1/menus/restaurant";
