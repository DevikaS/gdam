package com.adstream.automate.babylon.sut.pages.ordering.elements.dictionaries;

/*
 * Created by demidovskiy-r on 01.08.2014.
 */
public enum Mentions {
    MENTION_A("Mention A : Pour votre santé, mangez au moins cinq fruits et légumes par jour"),
    MENTION_B("Mention B : Pour votre santé, pratiquez une activité physique régulière"),
    MENTION_C("Mention C : Pour votre santé, évitez de manger trop gras, trop sucré, trop salé"),
    MENTION_D("Mention D : Pour votre santé, évitez de grignotter entre les repas"),
    MENTION_E("Mention E : Apprenez à votre enfant à ne pas grignoter entre les repas"),
    MENTION_F("Mention F : Bouger, jouer est indispensable au développement de votre enfant"),
    MENTION_G("Mention G : En plus du lait, l'eau est la seule boisson indispensable"),
    MENTION_H("Mention H : Pour ta santé, mange au moins cinq fruits et légumes par jour"),
    MENTION_I("Mention I : Pour ta santé, pratique une activité physique régulière"),
    MENTION_J("Mention J : Pour ta santé, évite de manger trop gras, trop sucré, trop salé"),
    MENTION_K("Mention K : Pour ta santé, évite de grignoter entre les repas"),
    MENTION_L("Mention L : Pour bien grandir, mange au moins cinq fruits et légumes par jour"),
    MENTION_M("Mention M : Pour être en forme, dépense-toi bien"),
    MENTION_N("Mention N : Pour être en forme, dépense-toi bien"),
    MENTION_O("Mention O : Pour être en forme, évite de grignoter dans la journée"),
    MENTION_V("Mention V : Jouer comporte des risques : endettement, dépendance... Appelez le 09-74-75-13-13 (appel non surtaxé)."),
    MENTION_W("Mention W: Jouer comporte des risques : isolement, endettement... Appelez le 09-74-75-13-13 (appel non surtaxé)."),
    MENTION_X("Mention X : Jouer comporte des risques : dépendance, isolement... Appelez le 09-74-75-13-13 (appel non surtaxé).");

    private String name;

    private Mentions(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return name;
    }

    public static String findByName(String name) {
        for (Mentions mentions : values())
            if (mentions.toString().equals(name))
                return mentions.toString();
        throw new IllegalArgumentException("Unknown mentions name: " + name);
    }
}